require 'mkmf'
require 'shellwords'
require 'fileutils'

def have_all(*args)
  old_libs = $libs.dup
  old_defs = $defs.dup
  result = []
  begin
    args.each {|arg|
      r = arg.call(*result)
      if !r
        return nil
      end
      result << r
    }
    result
  ensure
    if result.length != args.length
      $libs = old_libs
      $defs = old_defs
    end
  end
end

def exec_command(cmd)
  puts "> #{cmd}"
  if !system(cmd)
    STDERR.puts("External command failed")
    exit 1
  end
end

$mingw = /mingw/ =~ RUBY_PLATFORM
$mswin = /mswin/ =~ RUBY_PLATFORM
$windows = $mingw || $mswin
$x64 = /x64/ =~ RUBY_PLATFORM
$use_system_libs = arg_config('--use-system-libraries',
                              ENV.key?("CURSES_USE_SYSTEM_LIBRARIES"))
$idefault = nil
$ldefault = nil
$pdcurses_wide_default = nil
$pdcurses_dll_default = nil
$curses_version_default = nil
if !$use_system_libs && /mingw|mswin/ =~ RUBY_PLATFORM
  $pdcurses_wide_default = true
  $curses_version_default = "function"
  pdcurses_dir = File.expand_path("../../vendor/PDCurses", __dir__)
  $idefault = $ldefault = pdcurses_dir
  wincon_dir = File.expand_path("wincon", pdcurses_dir)
  old_dir == Dir.pwd
  Dir.chdir(wincon_dir)
  begin
    if $mswin
      exec_command "nmake -f Makefile.vc clean all WIDE=Y DLL=Y"
      FileUtils.cp("pdcurses.dll", pdcurses_dir)
      FileUtils.cp("pdcurses.lib", pdcurses_dir)
      $pdcurses_dll_default = true
    else
      if $x64
        exec_command "make -f Makefile.mng clean all _w64=1 WIDE=Y DLL=N"
      else
        exec_command "make -f Makefile.mng clean all WIDE=Y DLL=N"
      end
      FileUtils.cp("pdcurses.a", pdcurses_dir)
    end
  ensure
    Dir.chdir(old_dir)
  end
end

dir_config('curses', $idefault, $ldefault)
dir_config('ncurses')
dir_config('termcap')

have_library("mytinfo", "tgetent") if /bow/ =~ RUBY_PLATFORM
have_library("tinfow", "tgetent") ||
  have_library("tinfo", "tgetent") ||
  have_library("termcap", "tgetent")

header_library = nil
[
  ["ncursesw/curses.h", ["ncursesw"]],
  ["ncurses.h", ["ncursesw", "ncurses"]],
  ["ncurses/curses.h", ["ncurses"]],
  ["curses_colr/curses.h", ["cur_colr"]],
  ["curses.h", ["curses", "pdcurses"]],
  # ["xcurses.h", ["XCurses"]], # XCurses (PDCurses for X11)
].each {|hdr, libs|
  header_library = have_all(
    lambda { have_header(hdr) && hdr },
    lambda {|h| libs.find {|lib| have_library(lib, "initscr", h) } })
  if header_library
    break;
  end
}

if header_library
  header, library = header_library
  puts "header: #{header}"
  puts "library: #{library}"

  curses = [header]
  if header == 'curses_colr/curses.h'
    curses.unshift("varargs.h")
  end

  for f in %w(beep bkgd bkgdset curs_set deleteln doupdate flash
              getbkgd getnstr init isendwin keyname keypad resizeterm
              scrl set setscrreg ungetch addnwstr
              wattroff wattron wattrset wbkgd wbkgdset wdeleteln wgetnstr
              wresize wscrl wsetscrreg werase redrawwin waddnwstr mvderwin derwin
              touchwin untouchwin wtouchln is_linetouched is_wintouched
              def_prog_mode reset_prog_mode timeout wtimeout nodelay
              init_color wcolor_set use_default_colors assume_default_colors
              newpad unget_wch get_wch wget_wch PDC_get_key_modifiers)
    have_func(f) || (have_macro(f, curses) && $defs.push(format("-DHAVE_%s", f.upcase)))
  end
  convertible_int('chtype', [["#undef MOUSE_MOVED\n"]]+curses) or abort
  flag = "-D_XOPEN_SOURCE_EXTENDED"
  if checking_for("_XOPEN_SOURCE_EXTENDED") {
       try_compile(cpp_include(%w[stdio.h stdlib.h]+curses), flag, :werror => true)
     }
    $defs << flag
  end
  have_var("ESCDELAY", curses)
  have_var("TABSIZE", curses)
  have_var("COLORS", curses)
  have_var("COLOR_PAIRS", curses)

  # SVR4 curses has a (undocumented) variable char *curses_version.
  # ncurses and PDcurses has a function char *curses_version().
  # Note that the original BSD curses doesn't provide version information.
  #
  # configure option:
  #   --with-curses-version=function    for SVR4
  #   --with-curses-version=variable    for ncurses and PDcurses
  #   (not given)                       automatically determined
  with_curses_version = with_config("curses-version", $curses_version_default)
  case with_curses_version
  when "function"
    $defs << '-DHAVE_FUNC_CURSES_VERSION'
  when "variable"
    $defs << '-DHAVE_VAR_CURSES_VERSION'
  when nil
    func_test_program = cpp_include(curses) + <<-"End"
      int main(int argc, char *argv[])
      {
          curses_version();
          return EXIT_SUCCESS;
      }
    End
    var_test_program = cpp_include(curses) + <<-"End"
      extern char *curses_version;
      int main(int argc, char *argv[])
      {
          int i = 0;
          for (i = 0; i < 100; i++) {
              if (curses_version[i] == 0)
                  return 0 < i ? EXIT_SUCCESS : EXIT_FAILURE;
              if (curses_version[i] & 0x80)
                  return EXIT_FAILURE;
          }
          return EXIT_FAILURE;
      }
    End
    try = method(CROSS_COMPILING ? :try_link : :try_run)
    function_p = checking_for(checking_message('function curses_version', curses)) { try[func_test_program] }
    variable_p = checking_for(checking_message('variable curses_version', curses)) { try[var_test_program] }
    if function_p and variable_p
      if [header, library].grep(/ncurses|pdcurses|xcurses/i)
        variable_p = false
      else
        warn "found curses_version but cannot determine whether it is a"
        warn "function or a variable, so assume a variable in old SVR4"
        warn "ncurses."
        function_p = false
      end
    end
    $defs << '-DHAVE_FUNC_CURSES_VERSION' if function_p
    $defs << '-DHAVE_VAR_CURSES_VERSION' if variable_p
  else
    warn "unexpected value for --with-curses-version: #{with_curses_version}"
  end

  if enable_config("pdcurses-wide", $pdcurses_wide_default)
    $defs << '-DPDC_WIDE'
  end

  if enable_config("pdcurses-dll", $pdcurses_dll_default)
    $defs << '-DPDC_DLL_BUILD'
  end

  if (have_header("ncursesw/menu.h") ||
      have_header("ncurses/menu.h") ||
      have_header("curses/menu.h") ||
      have_header("menu.h")) &&
      (have_library("menuw", "new_menu") ||
       have_library("menu", "new_menu"))
    $defs << '-DHAVE_MENU'
  end

  if (have_header("ncursesw/form.h") ||
      have_header("ncurses/form.h") ||
      have_header("curses/form.h") ||
      have_header("form.h")) &&
      (have_library("formw", "new_form") ||
       have_library("form", "new_form"))
    $defs << '-DHAVE_FORM'
    have_func("form_driver_w")
  end

  ["WINDOW", "MEVENT", "ITEM", "MENU", "FIELD", "FORM"].each do |type|
    checking_for("sizeof(#{type}) is available") {
      if try_compile(<<EOF, Shellwords.join($defs))
#if defined(HAVE_NCURSESW_CURSES_H)
# include <ncursesw/curses.h>
#elif defined(HAVE_NCURSES_CURSES_H)
# include <ncurses/curses.h>
#elif defined(HAVE_NCURSES_H)
# include <ncurses.h>
#elif defined(HAVE_CURSES_COLR_CURSES_H)
# ifdef HAVE_STDARG_PROTOTYPES
#  include <stdarg.h>
# else
#  include <varargs.h>
# endif
# include <curses_colr/curses.h>
#else
# include <curses.h>
#endif

#if defined(HAVE_NCURSESW_MENU_H)
# include <ncursesw/menu.h>
#elif defined(HAVE_NCURSES_MENU_H)
# include <ncurses/menu.h>
#elif defined(HAVE_CURSES_MENU_H)
# include <curses/menu.h>
#elif defined(HAVE_MENU_H)
# include <menu.h>
#endif

#if defined(HAVE_NCURSESW_FORM_H)
# include <ncursesw/form.h>
#elif defined(HAVE_NCURSES_FORM_H)
# include <ncurses/form.h>
#elif defined(HAVE_CURSES_FORM_H)
# include <curses/form.h>
#elif defined(HAVE_FORM_H)
# include <form.h>
#endif

const int sizeof_#{type} = (int) sizeof(#{type});
EOF
        $defs << "-DCURSES_SIZEOF_#{type}=sizeof(#{type})"
        true
      else
        $defs << "-DCURSES_SIZEOF_#{type}=0"
        false
      end
    }
  end

  if RUBY_VERSION >= '2.1'
    create_header
    create_makefile("curses")
  else
    # curses is part of ruby-core pre-2.1.0, so this gem is not required. But
    # make pre-2.1.0 a no-op rather than failing or listing as unsupported, to
    # aid gems offering multi-version Ruby support.
    File.open("Makefile", 'w') do |f|
      f.puts dummy_makefile("curses").join
    end
  end
end

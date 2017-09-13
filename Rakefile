require "bundler"

Bundler::GemHelper.install_tasks

begin
  require 'rake/extensiontask'
rescue LoadError => e
  warn "\nmissing #{e.path} (for rake-compiler)" if e.respond_to? :path
  warn "run: bundle install\n\n"
end

$mswin = /mswin/ =~ RUBY_PLATFORM

CLOBBER.include("vendor/#{RUBY_PLATFORM}") if $mswin
CLOBBER.include("vendor/x86-mingw32")
CLOBBER.include("vendor/x64-mingw32")
CLOBBER.include("lib/2.*")
CLOBBER.include("pkg")

namespace :build do
  desc "Build PDCurses"
  task :pdcurses do
    mkdir_p "vendor/#{RUBY_PLATFORM}/PDCurses" if $mswin
    mkdir_p "vendor/x86-mingw32/PDCurses"
    mkdir_p "vendor/x64-mingw32/PDCurses"
    chdir "vendor/PDCurses/win32" do
      if $mswin
        sh "nmake -f vcwin32.mak clean all WIDE=Y DLL=Y"
        cp %w[pdcurses.dll pdcurses.lib], "../../#{RUBY_PLATFORM}/PDCurses"
      else
        sh "make -f mingwin32.mak clean all WIDE=Y DLL=Y"
        cp "pdcurses.dll", "../../x86-mingw32/PDCurses"

        sh "make -f mingwin32.mak clean all _w64=1 WIDE=Y DLL=Y"
        cp "pdcurses.dll", "../../x64-mingw32/PDCurses"
      end
    end
  end
end

namespace :clean do
  desc "Clean PDCurses"
  task :pdcurses do
    chdir "vendor/PDCurses/win32" do
      sh "nmake -f vcwin32.mak clean" if $mswin
      sh "make -f mingwin32.mak clean _linux_w64=1"
    end
  end
end

spec = eval(File.read(File.expand_path("curses.gemspec", __dir__)))
Rake::ExtensionTask.new(spec.name, spec) do |ext|
  if $mswin
    ext.config_options << '--with-curses-include=' + 
      File.expand_path("vendor/PDCurses", __dir__) +
      ' --with-curses-version=function --enable-pdcurses-wide' +
      ' --enable-pdcurses-dll' +
      ' --with-curses-lib=' +
      File.expand_path("vendor/#{RUBY_PLATFORM}/PDCurses", __dir__)
    spec.files += ["vendor/#{RUBY_PLATFORM}/PDCurses/pdcurses.dll"]
  end

  ext.cross_compile = true
  ext.cross_platform = ["x86-mingw32", "x64-mingw32"]
  ext.cross_config_options << '--with-curses-include=' + 
    File.expand_path("vendor/PDCurses", __dir__) +
    ' --with-curses-version=function --enable-pdcurses-wide'
  ext.cross_config_options << {
    'x86-mingw32' => '--with-curses-lib=' +
      File.expand_path("vendor/x86-mingw32/PDCurses", __dir__),
    'x64-mingw32' => '--with-curses-lib=' +
      File.expand_path("vendor/x64-mingw32/PDCurses", __dir__)
  }
  ext.cross_compiling do |_spec|
    bin_file = "vendor/#{_spec.platform}/PDCurses/pdcurses.dll"
    _spec.files += [bin_file]
    stage_file = "#{ext.tmp_dir}/#{_spec.platform}/stage/#{bin_file}"
    stage_dir = File.dirname(stage_file)
    directory stage_dir
    file stage_file => [stage_dir, bin_file] do
      cp bin_file, stage_file
    end
  end
end

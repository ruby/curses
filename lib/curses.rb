platform = RUBY_PLATFORM.sub(/i[3-7]86/, "x86")
pdcurses_path = File.expand_path("../vendor/#{platform}/PDCurses", __dir__)
pdcurses_bundled = File.directory?(pdcurses_path)
if pdcurses_bundled
  path = ENV["PATH"]
  dir = File::ALT_SEPARATOR ?
    pdcurses_path.tr("/", File::ALT_SEPARATOR) : dir
  dirs = path.split(File::PATH_SEPARATOR)
  if !dirs.include?(dir)
    ENV["PATH"] = [dir, *dirs].join(File::PATH_SEPARATOR)
  end
end

begin
  major, minor, _ = RUBY_VERSION.split(/\./)
  require "#{major}.#{minor}/curses.so"
rescue LoadError
  require "curses.so"
end

if pdcurses_bundled
  Curses.keyboard_encoding = Encoding::UTF_8
end

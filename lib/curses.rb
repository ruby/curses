pdcurses_path = File.expand_path("../vendor/#{RUBY_PLATFORM}/PDCurses", __dir__)
if File.directory?(pdcurses_path)
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

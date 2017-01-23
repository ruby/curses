begin
  major, minor, _ = RUBY_VERSION.split(/\./)
  require "#{major}.#{minor}/curses.so"
rescue LoadError
  require "curses.so"
end

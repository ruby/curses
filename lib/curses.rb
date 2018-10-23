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

if defined?(Curses::Menu)
  class Curses::Menu
    def left_item
      driver(Curses::REQ_LEFT_ITEM)
    end

    def right_item
      driver(Curses::REQ_RIGHT_ITEM)
    end

    def up_item
      driver(Curses::REQ_UP_ITEM)
    end

    def down_item
      driver(Curses::REQ_DOWN_ITEM)
    end

    def scroll_up_line
      driver(Curses::REQ_SCR_ULINE)
    end

    def scroll_down_line
      driver(Curses::REQ_SCR_DLINE)
    end

    def scroll_up_page
      driver(Curses::REQ_SCR_UPAGE)
    end

    def scroll_down_page
      driver(Curses::REQ_SCR_DPAGE)
    end

    def first_item
      driver(Curses::REQ_FIRST_ITEM)
    end

    def last_item
      driver(Curses::REQ_LAST_ITEM)
    end

    def next_item
      driver(Curses::REQ_NEXT_ITEM)
    end

    def prev_item
      driver(Curses::REQ_PREV_ITEM)
    end

    def toggle_item
      driver(Curses::REQ_TOGGLE_ITEM)
    end

    def clear_pattern
      driver(Curses::REQ_CLEAR_PATTERN)
    end

    def back_pattern
      driver(Curses::REQ_BACK_PATTERN)
    end

    def next_match
      driver(Curses::REQ_NEXT_MATCH)
    end

    def prev_match
      driver(Curses::REQ_PREV_MATCH)
    end
  end
end


pdcurses_dll = File.expand_path("../vendor/PDCurses/pdcurses.dll", __dir__)
if File.exist?(pdcurses_dll)
  path = ENV["PATH"]
  dir = File.dirname(pdcurses_dll)
  dir = dir.tr("/", File::ALT_SEPARATOR) if File::ALT_SEPARATOR
  dirs = path.split(File::PATH_SEPARATOR)
  if !dirs.include?(dir)
    ENV["PATH"] = [dir, *dirs].join(File::PATH_SEPARATOR)
  end
end

require "curses.so"

if /mingw|mswin/ =~ RUBY_PLATFORM
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

module Curses
  module_function

  def chgat(...)
    Curses.stdscr.chgat(...)
  end
end

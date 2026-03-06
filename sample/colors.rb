#!/usr/bin/env ruby

require "curses"
include Curses

# The TERM environment variable should be set to xterm-256color etc. to
# use 256 colors.  Curses.colors returns the color numbers of the terminal.
# With ncurses 6+ extended color support, color_pairs may exceed 256.

begin
  init_screen

  if !Curses.has_colors?
    addstr "This Terminal does not support colors!"
  else
    start_color

    extended = Curses.support_extended_colors?
    addstr "This Terminal supports #{colors} colors, #{color_pairs} pairs"
    addstr extended ? " (extended).\n" : ".\n"

    (extended ? [512, color_pairs].min : colors).times { |i|
      next if i == 0
      Curses.init_pair(i, i % colors, (i / colors) % colors)
      if extended
        # color_pair() encodes into chtype and can't handle pairs > 255;
        # use color_set on stdscr instead, which calls wattr_set internally.
        stdscr.color_set(i)
      else
        attrset(color_pair(i))
      end
      addstr("#{i.to_s.rjust(3)} ")
      addstr("\n") if i == 15 || (i > 16 && (i - 15) % 36 == 0)
    }
    stdscr.color_set(0)
  end

  getch

ensure
  close_screen
end

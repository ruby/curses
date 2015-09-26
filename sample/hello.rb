#!/usr/bin/env ruby

require "curses"

def show_message(message)
  height, width = 5, message.length + 6
  top, left = (Curses.lines - height) / 2, (Curses.cols - width) / 2
  win = Curses::Window.new(height, width, top, left)
  win.box("|", "-")
  win.setpos(2, 3)
  win.addstr(message)
  win.refresh
  win.getch
  win.close
end

Curses.init_screen
begin
  Curses.crmode
  Curses.setpos((Curses.lines - 1) / 2, (Curses.cols - 11) / 2)
  Curses.addstr("Hit any key")
  Curses.refresh
  Curses.getch
  show_message("Hello, World!")
ensure
  Curses.close_screen
end

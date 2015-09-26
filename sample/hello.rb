#!/usr/bin/env ruby

require "curses"
include Curses

def show_message(message)
  height, width = 5, message.length + 6
  top, left = (lines - height) / 2, (cols - width) / 2
  win = Window.new(height, width, top, left)
  win.box("|", "-")
  win.setpos(2, 3)
  win.addstr(message)
  win.refresh
  win.getch
  win.close
end

init_screen
begin
  crmode
  setpos((lines - 1) / 2, (cols - 11) / 2)
  addstr("Hit any key")
  refresh
  getch
  show_message("Hello, World!")
ensure
  close_screen
end

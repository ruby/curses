#!/usr/bin/env ruby

require "curses"

Curses.init_screen
Curses.cbreak
Curses.noecho
Curses.stdscr.keypad = true
at_exit do
  Curses.close_screen
end

menu = Curses::Menu.new([
  Curses::Item.new("Apple", "Red fruit"),
  Curses::Item.new("Orange", "Orange fruit"),
  Curses::Item.new("Banana", "Yellow fruit")
])
menu.post

while ch = Curses.getch
  begin
    case ch
    when Curses::KEY_UP, ?k
      menu.up_item
    when Curses::KEY_DOWN, ?j
      menu.down_item
    else
      break
    end
  rescue Curses::RequestDeniedError
  end
end

menu.unpost

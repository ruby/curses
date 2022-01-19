#!/usr/bin/env ruby
# require_relative "../lib/curses"
require 'curses'

include Curses

init_screen
begin
  addstr("The following letter A should be BOLD and UNDERLINED by using addch:\n")
  addch('A'.ord | A_BOLD | A_UNDERLINE)

  addstr("\nIt should look the same as when using attron and addstr:\n")
  attron(A_BOLD | A_UNDERLINE)
  addstr("A")
  getch

ensure
  close_screen
end

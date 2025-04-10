require "curses"

screen = Curses::Screen.new(STDOUT, STDIN, "xterm")
screen.set_term

Curses.addstr("Hit any key")
Curses.refresh
Curses.getch
Curses.close_screen

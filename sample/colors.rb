require "curses"
include Curses

begin
  init_screen

  if !Curses.has_colors?
    addstr "This Terminal does not support colors!"
  else
    start_color

    addstr "This Terminal supports #{colors} colors.\n"

    Curses.colors.times { |i|
      Curses.init_pair(i, i, 0)
      attrset(color_pair(i))
      addstr("#{i.to_s.rjust(3)} ")
      addstr("\n") if i == 15 || (i > 16 && (i - 15) % 36 == 0)
    }
  end

  getch

ensure
  close_screen
end
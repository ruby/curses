#!/usr/bin/env ruby
#
# Mouse movement tracking using CSI 1003 and 1006 (SGR). Will print a cursor that moves with the mouse.
#

require "curses"
include Curses

@positions = []

def draw_cursor(y, x, button, state)

  # Keep a trail of 10 previous positions visible on the screen
  if @positions.size >= 10
    y_old, x_old = @positions.shift
    setpos(y_old, x_old)
    addstr(" ")
  end

  setpos(2, 1)
  addstr("Mouse is at y=#{y.to_s.ljust(3)} x=#{x.to_s.ljust(3)} button=#{button.to_s.ljust(3)} #{'%08b' % button}")

  setpos(y, x)
  addstr("+")
  @positions << [y, x]
end

init_screen
crmode
noecho
stdscr.box('|', "-")
setpos(1,1)
addstr("Please move your mouse. Press 'q' to close.")

begin
  # Switch on mouse continous position reporting
  print("\x1b[?1003h")

  # Also enable SGR extended reporting, because otherwise we can only
  # receive values up to 160x94. Everything else confuses Ruby Curses.
  print("\x1b[?1006h")

  loop do
    c = get_char
    case c
    when "q"
      return
    when "\e" # ESC
      case get_char
      when '['
        csi = ""
        loop do
          d = get_char
          csi += d
          if d.ord >= 0x40 && d.ord <= 0x7E
            break
          end
        end
        if /<(\d+);(\d+);(\d+)(m|M)/ =~ csi
          button = $1.to_i
          x = $2.to_i
          y = $3.to_i
          state = $4
          draw_cursor(y, x, button, state)
        end
      end
    end
  end

ensure
  print("\x1b[?1003l")
  print("\x1b[?1006l")
  close_screen
end


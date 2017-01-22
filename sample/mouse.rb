#!/usr/bin/env ruby

require "curses"
include Curses

def show_message(*msgs)
  message = msgs.join
  height, width = 5, message.length + 6
  top, left = (lines - height) / 2, (cols - width) / 2
  win = Window.new(height, width, top, left)
  win.keypad = true
  win.attron(color_pair(COLOR_RED)) do
    win.box("|", "-", "+")
  end
  win.setpos(2, 3)
  win.addstr(message)
  win.refresh
  win.getch
  win.close
end

init_screen
start_color
init_pair(COLOR_BLUE, COLOR_BLUE, COLOR_WHITE)
init_pair(COLOR_RED, COLOR_RED, COLOR_WHITE)
crmode
noecho
stdscr.keypad(true)

begin
  mousemask(BUTTON1_CLICKED|BUTTON2_CLICKED|BUTTON3_CLICKED|BUTTON4_CLICKED)
  setpos((lines - 1) / 2, (cols - 5) / 2)
  attron(color_pair(COLOR_BLUE)|A_BOLD) do
    addstr("click")
  end
  refresh
  loop do
    c = getch
    case c
    when KEY_MOUSE
      m = getmouse
      if m
        show_message("getch = #{c.inspect}, ",
                     "mouse event = #{'0x%x' % m.bstate}, ",
                     "axis = (#{m.x},#{m.y},#{m.z})")
      end
      break
    end
  end
  refresh
ensure
  close_screen
end

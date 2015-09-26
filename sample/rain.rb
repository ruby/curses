#!/usr/bin/env ruby

require "curses"
include Curses

def onsig(signal)
  close_screen
  exit signal
end

def place_string(y, x, string)
  setpos(y, x)
  addstr(string)
end

def cycle_index(index)
  (index + 1) % 5
end

%w[HUP INT QUIT TERM].each do |sig|
  unless trap(sig, "IGNORE") == "IGNORE"  # previous handler
    trap(sig) {|s| onsig(s) }
  end
end

init_screen
nl
noecho
curs_set 0
srand

xpos, ypos = {}, {}
x_range = 2..(cols - 3)
y_range = 2..(lines - 3)
(0..4).each do |i|
  xpos[i], ypos[i] = rand(x_range), rand(y_range)
end

i = 0
loop do
  x, y = rand(x_range), rand(y_range)

  place_string(y, x, ".")

  place_string(ypos[i], xpos[i], "o")

  i = cycle_index(i)
  place_string(ypos[i], xpos[i], "O")

  i = cycle_index(i)
  place_string(ypos[i] - 1, xpos[i],      "-")
  place_string(ypos[i],     xpos[i] - 1, "|.|")
  place_string(ypos[i] + 1, xpos[i],      "-")

  i = cycle_index(i)
  place_string(ypos[i] - 2, xpos[i],       "-")
  place_string(ypos[i] - 1, xpos[i] - 1,  "/ \\")
  place_string(ypos[i],     xpos[i] - 2, "| O |")
  place_string(ypos[i] + 1, xpos[i] - 1, "\\ /")
  place_string(ypos[i] + 2, xpos[i],       "-")

  i = cycle_index(i)
  place_string(ypos[i] - 2, xpos[i],       " ")
  place_string(ypos[i] - 1, xpos[i] - 1,  "   ")
  place_string(ypos[i],     xpos[i] - 2, "     ")
  place_string(ypos[i] + 1, xpos[i] - 1,  "   ")
  place_string(ypos[i] + 2, xpos[i],       " ")

  xpos[i], ypos[i] = x, y

  refresh
  sleep(0.5)
end

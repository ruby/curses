#!/usr/bin/env ruby
# rain for a curses test

require "curses"
include Curses

def onsig(sig)
  close_screen
  exit sig
end

def ranf
  rand(32767).to_f / 32767
end

# main #
%w[HUP INT QUIT TERM].each do |i|
  unless trap(i, "SIG_IGN") == "IGNORE"  # handler was "IGNORE"
    trap(i) {|sig| onsig(sig) }
  end
end

init_screen
nl
noecho
curs_set 0
srand

xpos = {}
ypos = {}
r = lines - 4
c = cols - 4
(0..4).each do |i|
  xpos[i] = (c * ranf).to_i + 2
  ypos[i] = (r * ranf).to_i + 2
end

i = 0
loop do
  x = (c * ranf).to_i + 2
  y = (r * ranf).to_i + 2


  setpos(y, x); addstr(".")

  setpos(ypos[i], xpos[i]); addstr("o")

  i = if i == 0 then 4 else i - 1 end
  setpos(ypos[i], xpos[i]); addstr("O")

  i = if i == 0 then 4 else i - 1 end
  setpos(ypos[i] - 1, xpos[i]);      addstr("-")
  setpos(ypos[i],     xpos[i] - 1); addstr("|.|")
  setpos(ypos[i] + 1, xpos[i]);      addstr("-")

  i = if i == 0 then 4 else i - 1 end
  setpos(ypos[i] - 2, xpos[i]);       addstr("-")
  setpos(ypos[i] - 1, xpos[i] - 1);  addstr("/ \\")
  setpos(ypos[i],     xpos[i] - 2); addstr("| O |")
  setpos(ypos[i] + 1, xpos[i] - 1); addstr("\\ /")
  setpos(ypos[i] + 2, xpos[i]);       addstr("-")

  i = if i == 0 then 4 else i - 1 end
  setpos(ypos[i] - 2, xpos[i]);       addstr(" ")
  setpos(ypos[i] - 1, xpos[i] - 1);  addstr("   ")
  setpos(ypos[i],     xpos[i] - 2); addstr("     ")
  setpos(ypos[i] + 1, xpos[i] - 1);  addstr("   ")
  setpos(ypos[i] + 2, xpos[i]);       addstr(" ")


  xpos[i] = x
  ypos[i] = y
  refresh
  sleep(0.5)
end

# end of main

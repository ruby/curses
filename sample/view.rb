#!/usr/bin/env ruby

require "curses"
include Curses

#
# main
#

unless ARGV.size == 1
  puts "usage: #{$0} file"
  exit
end
begin
  fp = open(ARGV[0], "r")
rescue
  raise "cannot open file: #{ARGV[0]}"
end

# signal(SIGINT, finish)

init_screen
#keypad(stdscr, true)
nonl
cbreak
noecho
#scrollok(stdscr, true)

# slurp the file
data_lines = []
fp.each_line {|l| data_lines.push(l) }
fp.close


lptr = 0
loop do
  lines.times do |i|
    setpos(i, 0)
    #clrtoeol
    addstr(data_lines[lptr + i] || "")
  end
  refresh

  explicit = false
  n = 0
  c = nil
  loop do
    c = getch
    if c =~ /[0-9]/
      n = 10 * n + c.to_i
      explicit = true
    else
      break
    end
  end

  n = 1 if !explicit && n == 0

  case c
  when "n"  #when KEY_DOWN
    i = 0
    n.times do
      if lptr + lines < data_lines.size
        lptr += 1
      else
        break
      end
      i += 1
    end
    #wscrl(i)

  when "p"  #when KEY_UP
    i = 0
    n.times do
      if lptr > 0
        lptr -= 1
      else
        break
      end
      i += 1
    end
    #wscrl(-i)

  when "q"
    break
  end

end
close_screen

require "curses"

Curses.init_screen
Curses.cbreak
Curses.noecho
Curses.stdscr.keypad = true
at_exit do
  Curses.cloes_screen
end

menu = Curses::Menu.new([
  Curses::Item.new("Apple", "Red fruit"),
  Curses::Item.new("Orange", "Orange fruit"),
  Curses::Item.new("Banana", "Yello fruit")
])
menu.post

while ch = Curses.getch
  begin
    case ch
    when Curses::KEY_UP, ?k
      menu.driver(Curses::REQ_UP_ITEM)
    when Curses::KEY_DOWN, ?j
      menu.driver(Curses::REQ_DOWN_ITEM)
    else
      break
    end
  rescue Curses::RequestDeniedError
  end
end

menu.unpost

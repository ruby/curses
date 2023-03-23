require "curses"

Curses.init_screen
Curses.cbreak
Curses.noecho
Curses.stdscr.keypad = true
at_exit do
  Curses.close_screen
end

fields = [
  Curses::Field.new(1, 10, 4, 18, 0, 0),
  Curses::Field.new(1, 10, 6, 18, 0, 0)
]
fields.each do |field|
  field.set_back(Curses::A_UNDERLINE)
  field.opts_off(Curses::O_AUTOSKIP)
end

form = Curses::Form.new(fields)
form.post

Curses.setpos(4, 10)
Curses.addstr("Value 1:")
Curses.setpos(6, 10)
Curses.addstr("Value 2:")

while ch = Curses.get_char
  begin
    case ch
    when Curses::KEY_F1
      break
    when Curses::KEY_DOWN
      form.driver(Curses::REQ_NEXT_FIELD)
      form.driver(Curses::REQ_END_LINE)
    when Curses::KEY_UP
      form.driver(Curses::REQ_PREV_FIELD)
      form.driver(Curses::REQ_END_LINE)
    when Curses::KEY_RIGHT
      form.driver(Curses::REQ_NEXT_CHAR)
    when Curses::KEY_LEFT
      form.driver(Curses::REQ_PREV_CHAR)
    when Curses::KEY_BACKSPACE
      form.driver(Curses::REQ_DEL_PREV)
    else
      form.driver(ch)
    end
  rescue Curses::RequestDeniedError, Curses::UnknownCommandError
  end
end

form.unpost

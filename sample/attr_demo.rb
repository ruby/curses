require "curses"
include Curses

init_screen
begin
  attrs = {
    A_NORMAL =>     'Normal display (no highlight)',
    A_STANDOUT =>   'Best highlighting mode of the terminal',
    A_UNDERLINE =>  'Underlining',
    A_REVERSE =>    'Reverse video',
    A_BLINK =>      'Blinking',
    A_DIM =>        'Half bright',
    A_BOLD =>       'Extra bright or bold',
    A_PROTECT =>    'Protected mode',
    A_INVIS =>      'Invisible or blank mode',
    A_ALTCHARSET => 'Alternate character set',
  }

  longest_description = attrs.values.map(&:size).max
  attrs.each { |attribute, description|

    attrset(A_NORMAL)
    addstr("#{description.ljust(longest_description)}: ")

    attrset(attribute)
    addstr([*('a'..'z'), *('0'..'9')].join + "\n")
  }
  getch
  setpos(0, 0)
  Curses.stdscr.chgat(6, A_UNDERLINE)
  getch
ensure
  close_screen
end
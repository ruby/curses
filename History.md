### 1.1.3 / 2017-02-08

Bug fixes:

* Update PDCurses to handle extended keys.

### 1.1.2 / 2017-02-06

Bug fixes:

* Use the left-alt-fix branch of https://github.com/shugo/PDCurses.git to get
  ALT + < etc.

### 1.1.1 / 2017-01-25

Bug fixes:

* Add -DPDC_WIDE to CPPFLAGS when compiling with PDCurses.

### 1.1.0 / 2017-01-24

New features:

* Use bundler instead of hoe.  Pull request #18 by hsbt.
* Enable appveyor.  Pull request #19 by hsbt.
* Add badges for build status to README.md.  Pull request #20 by hsbt.
* Add Curses.erase and Curses::Window.erase.
* Add Curses::Window.redraw.
* Add Curses.unget_char, Curses.get_char, and Curses::Window.get_char for
  multibyte characters.
* Add Curses.keyboard_encoding and Curses.terminal_encoding.
* Support cross compilation for mingw32.

Bug fixes:

* Fix error in attron/attroff documentation.  Pull request #14 by stomar.
* Improve code samples.  Pull request #15 by stomar.

### 1.0.2 / 2016-03-15

Bug fixes:

* Fix ncursesw support.  Pull request #16 by peter50216, patch by eTM.  Issue
  #6 by Jean Lazarou.

### 1.0.1 / 2014-03-26

Bug fixes:

* Curses install is a no-op on ruby with bundled curses.  Pull request #4
  tiredpixel.

### 1.0.0 / 2013-12-10

Birthday!


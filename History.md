### 1.2.4 / 2017-09-13

New features:

* Update PDCurses.

Bug fixes:

* Fix the path of pdcurses.dll for i386-mingw.  (Issue #36)

Documentation:

* Include reference to ncurses dependency.  Pull request #34 by qume.

### 1.2.3 / 2017-07-03

Bug fixes:

* Fixes for mswin.  Pull requests #30, #31, #32 and #33 by unak.

### 1.2.2 / 2017-04-22

New features:

* Add Curses.get_key_modifiers, Curses.return_key_modifiers, and
  Curses.save_key_modifiers.
* Support mswin native build.  Pull request #29 by usa.

### 1.2.1 / 2017-03-27

New features:

* Add touch, untouch, touched?, touch_line, and line_touched?.

Bug fixes:

* Fix Pad#subpad to use subpad(3). (Issue #23)
* Fix build issues on macOS.  Pull requests #24, #25, #26, #27 and #28 by nobu.

### 1.2.0 / 2017-02-19

New features:

* Add Curses.assume_default_colors.

Bug fixes:

* Curses.unget_char should use String#ord even if unget_wch() is not available.
* The default value of keyboard_encoding should be ASCII-8BIT if get_wch() is
  not available.
* NUM2ULONG() should be used in Window#bkgd etc.

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


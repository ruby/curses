# curses

[![Gem Version](https://badge.fury.io/rb/curses.svg)](https://badge.fury.io/rb/curses)
[![ubuntu](https://github.com/ruby/curses/workflows/ubuntu/badge.svg)](https://github.com/ruby/curses/actions?query=workflow%3Aubuntu)
[![windows](https://github.com/ruby/curses/workflows/windows/badge.svg)](https://github.com/ruby/curses/actions?query=workflow%3Awindows)
[![macos](https://github.com/ruby/curses/workflows/macos/badge.svg)](https://github.com/ruby/curses/actions?query=workflow%3Amacos)

* https://github.com/ruby/curses
* https://github.com/ruby/curses/issues

## Description

A Ruby binding for curses, ncurses, and PDCurses.
curses is an extension library for text UI applications.

Formerly part of the Ruby standard library, [curses was removed and placed in this gem][1]
with the release of Ruby 2.1.0. (see [ruby/ruby@9c5b2fd][2])

## Install

    $ gem install curses

Requires ncurses or ncursesw (with wide character support).
On Debian based distributions, you can install it with apt:

    $ apt install libncurses5-dev

Or

    $ apt install libncursesw5-dev

On Windows, `gem install curses` will build bundled PDCurses, so you
don't need to install extra libraries.
However, if you prefer ncurses to PDCurses, specify the following option:

    > gem install curses -- --use-system-libraries

On mingw, you need DevKit to compile the extension library.

## Documentation

See [https://www.rubydoc.info/gems/curses](https://www.rubydoc.info/gems/curses).

## Developers

After checking out the repo, run `bundle install` to install dependencies.

To compile the extension library, run `bundle exec rake compile`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `curses.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
## License

curses is released under the Ruby and 2-clause BSD licenses.  See COPYING for
details.

It includes a forked version of PDCurses, which is in the public domain:

  https://github.com/Bill-Gray/PDCurses

The version for Win32 console mode in the wincon subdirectory is used.

[1]: https://bugs.ruby-lang.org/issues/8584
[2]: https://github.com/ruby/ruby/commit/9c5b2fd8aa0fd343ad094d47a638cfd3f6ae0a81

# curses

[![Gem Version](https://badge.fury.io/rb/curses.svg)](https://badge.fury.io/rb/curses)
[![Build Status](https://travis-ci.org/ruby/curses.svg?branch=master)](https://travis-ci.org/ruby/curses)
[![Build status](https://ci.appveyor.com/api/projects/status/kdvksgjo4fyd3c4m/branch/master?svg=true)](https://ci.appveyor.com/project/ruby/curses/branch/master)

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

## Developers

After checking out the repo, run `bundle install` to install dependencies.

To compile the extension library, run `bundle exec rake compile`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `curses.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

### Cross compilation for Windows on Debian GNU/Linux based platforms

1. Install development environment fo 32- and 64-bit Windows.

   ```
   $ sudo apt-get install mingw-w64
   ```

2. Install rake-compiler.

   ```
   $ gem install rake-compiler
   ```

3. Compile multiple versions of Ruby.

   ```
   $ rake-compiler cross-ruby HOST=i686-w64-mingw32 VERSION=2.2.6
   $ rake-compiler cross-ruby HOST=i686-w64-mingw32 VERSION=2.3.3
   $ rake-compiler cross-ruby HOST=i686-w64-mingw32 VERSION=2.4.0
   $ rake-compiler cross-ruby HOST=x86_64-w64-mingw32 VERSION=2.2.6
   $ rake-compiler cross-ruby HOST=x86_64-w64-mingw32 VERSION=2.3.3
   $ rake-compiler cross-ruby HOST=x86_64-w64-mingw32 VERSION=2.4.0
   ```

3. Compile PDCurses.

   ```
   $ rake build:pdcurses
   ```

5. Compile curses.gem.

   ```
   $ rake RUBY_CC_VERSION=2.3.3:2.4.0 cross clean compile native gem
   ```

Binary gems are generated in pkg/.

## License

curses is released under the Ruby and 2-clause BSD licenses.  See COPYING for
details.

Binary gems for mingw32 include a forked version of PDCurses, which is in
the public domain:

  https://github.com/Bill-Gray/PDCurses

The version for Win32 console mode in the win32 subdirectory is used.

[1]: https://bugs.ruby-lang.org/issues/8584
[2]: https://github.com/ruby/ruby/commit/9c5b2fd8aa0fd343ad094d47a638cfd3f6ae0a81

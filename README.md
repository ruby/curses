# curses

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

## Developers

After checking out the repo, run `bundle install` to install dependencies.

To compile the extension library, run `bundle exec rake compile`.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `curses.gemspec`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

curses is released under the Ruby and 2-clause BSD licenses.  See COPYING for
details.

[1]: https://bugs.ruby-lang.org/issues/8584
[2]: https://github.com/ruby/ruby/commit/9c5b2fd8aa0fd343ad094d47a638cfd3f6ae0a81

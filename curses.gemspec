require 'rubygems'
Gem::Specification.new { |s|
  s.name = "curses"
  s.version = "1.0.2"
  s.author = "Shugo Maeda"
  s.email = "shugo@ruby-lang.org"
  s.homepage = "http://github.com/shugo/curses"
  s.platform = Gem::Platform::RUBY
  s.summary = "curses binding for Ruby"
  s.files = Dir.glob('{lib,ext,sample}/**/*') + ['README.md', 'COPYING', 'BSDL']
  s.extensions = ["ext/curses/extconf.rb"]
  s.require_path = "lib"
}

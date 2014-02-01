require 'rubygems'
Gem::Specification.new { |s|
  s.name = "curses"
  s.version = "0.0.1"
  s.date = "2013-06-28"
  s.author = "Shugo Maeda"
  s.email = "shugo@ruby-lang.org"
  s.homepage = "http://github.com/shugo/curses"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = '>= 2.1.0'
  s.summary = "curses binding for Ruby"
  s.files = Dir.glob('{lib,ext,sample}/**/*') + ['README.md', 'COPYING', 'BSDL']
  s.extensions = ["ext/curses/extconf.rb"]
  s.require_path = "lib"
}

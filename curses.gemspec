Gem::Specification.new { |s|
  s.name = "curses"
  s.version = "1.0.2"
  s.author = ["Shugo Maeda", 'Eric Hodel']
  s.email = ["shugo@ruby-lang.org", 'drbrain@segment7.net']
  s.homepage = "https://github.com/ruby/curses"
  s.platform = Gem::Platform::RUBY
  s.summary = "curses binding for Ruby"
  s.files = Dir.glob('{lib,ext,sample}/**/*') + ['README.md', 'COPYING', 'BSDL']
  s.extensions = ["ext/curses/extconf.rb"]
  s.require_path = "lib"
  s.licenses = ['Ruby', 'BSD-2-Clause']
  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rake-compiler'
}

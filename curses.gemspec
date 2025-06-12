Gem::Specification.new { |s|
  s.name = "curses"
  s.version = "1.5.2"
  s.author = ["Shugo Maeda", 'Eric Hodel']
  s.email = ["shugo@ruby-lang.org", 'drbrain@segment7.net']
  s.homepage = "https://github.com/ruby/curses"
  s.platform = Gem::Platform::RUBY
  s.summary = "A Ruby binding for curses, ncurses, and PDCurses. curses is an extension library for text UI applications. Formerly part of the Ruby standard library, [curses was removed and placed in this gem][1] with the release of Ruby 2.1.0. (see [ruby/ruby@9c5b2fd][2])"
  s.files = `git ls-files --recurse-submodules -z`.split("\x0")
  s.extensions = ["ext/curses/extconf.rb"]
  s.require_path = "lib"
  s.required_ruby_version = Gem::Requirement.new('>= 3.0')
  s.licenses = ['Ruby', 'BSD-2-Clause']
  s.homepage = "https://ruby.github.io/curses"
  s.licenses = ["Ruby"]

  s.metadata["homepage_uri"] = s.homepage
  s.metadata["source_code_uri"] = "https://github.com/ruby/curses"
  s.metadata["changelog_uri"] = "#{s.metadata['source_code_uri']}/releases"
  s.metadata["documentation_uri"] = s.homepage

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
}

# -*- ruby -*-

require 'rubygems'
require 'hoe'
begin
  require 'rake/extensiontask'
rescue LoadError => e
  warn "\nmissing #{e.path} (for rake-compiler)" if e.respond_to? :path
  warn "run: rake newb\n\n"
end

Hoe.plugin :git
Hoe.plugin :minitest
Hoe.plugin :travis

HOE = Hoe.spec 'curses' do
  self.version = '1.0.2'

  developer 'Eric Hodel', 'drbrain@segment7.net'
  developer 'Shugo Maeda', ''

  license 'Ruby'
  license 'BSD-2-Clause'

  self.extra_rdoc_files << 'ext/curses/curses.c'
  self.spec_extras[:extensions] = 'ext/curses/extconf.rb'

  self.readme_file  = 'README.md'
  self.history_file = 'History.md'

  self.extra_dev_deps << ['rake-compiler', '~> 0.8']
end

if Rake.const_defined? :ExtensionTask then
  Rake::ExtensionTask.new 'curses', HOE.spec

  task default: :compile
  task test: :compile
end

# vim: syntax=ruby

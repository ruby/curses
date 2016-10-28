require "bundler/gem_tasks"

begin
  require 'rake/extensiontask'
rescue LoadError => e
  warn "\nmissing #{e.path} (for rake-compiler)" if e.respond_to? :path
  warn "run: bundle install\n\n"
end

Rake::ExtensionTask.new('curses')

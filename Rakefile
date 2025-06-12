require "bundler"

Bundler::GemHelper.install_tasks

begin
  require "rdoc/task"
  RDoc::Task.new do |doc|
    doc.main   = "README.md"
    doc.title  = "Curses: A Ruby binding for curses, ncurses, and PDCurses."
    doc.rdoc_files = FileList.new %w[ext lib README.md BSDL COPYING]
    doc.rdoc_dir = "_site" # for github pages
  end
rescue LoadError
end

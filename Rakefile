require "bundler/gem_tasks"
require "rake/clean"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs = %w(lib spec)
  t.test_files = FileList["spec/**/*_spec.rb"]
end

task default: :test

require "bundler/gem_tasks"

require 'rake/testtask'
 
Rake::TestTask.new do |t|
  t.libs << 'lib/gapi-ruby'
  t.test_files = FileList['test/lib/gapi-ruby/*_test.rb']
  t.verbose = true
end
 
task :default => :test

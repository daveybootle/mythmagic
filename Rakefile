#!/usr/bin/env rake
require 'rake/testtask'

task :default => [:test]

Rake::TestTask.new do |t|
  t.warning = false
  t.verbose = false
  t.test_files = FileList['test/*_test.rb']
end

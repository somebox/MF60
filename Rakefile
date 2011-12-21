require "bundler/gem_tasks"
require 'rake/testtask'
require 'rake/clean'

task :default => [:test]

desc 'Run tests (default)'
Rake::TestTask.new(:test) do |t|
  t.test_files = Dir.glob 'test/*_test.rb'
  t.ruby_opts = ['-Ilib','-rubygems']
end
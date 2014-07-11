# encoding: utf-8

require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'

require 'rake'
require 'rspec/core/rake_task'
require 'appraisal'

RSpec::Core::RakeTask.new(:spec)

desc 'Default'
task :default do
  if ENV['BUNDLE_GEMFILE'] =~ /gemfiles/
    Rake::Task['spec'].invoke
  else
    Rake::Task['appraise'].invoke
  end
end

task :appraise do
  exec 'appraisal install && appraisal rake'
end

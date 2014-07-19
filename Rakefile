require "bundler/gem_tasks"
require 'cucumber/rake/task'
require 'rspec/core/rake_task'


def set_cucumber_options(options)
  ENV['CUCUMBER_OPTS'] = options
end

def combine_options(set_1, set_2)
  set_2 ? "#{set_1} #{set_2}" : set_1
end


task :clear_coverage do
  code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

  FileUtils.remove_dir(code_coverage_directory, true)
end

desc 'Run all Cucumber tests for the gem'
task :tests, [:options] do |t, args|
  set_cucumber_options(combine_options("-t ~@wip -t ~@off -f progress", args[:options]))
end
Cucumber::Rake::Task.new(:tests)

desc 'Run all RSpec tests for the gem'
RSpec::Core::RakeTask.new(:specs) do |t|
  t.rspec_opts = "-t ~wip -t ~off"
end

desc 'Run All The Things'
task :everything => :clear_coverage do
  Rake::Task[:specs].invoke
  Rake::Task[:tests].invoke
end

task :default => :everything

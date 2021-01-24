require 'cucumber/rake/task'
require 'rspec/core/rake_task'

namespace 'cql' do

  desc 'Removes the current code coverage data'
  task :clear_coverage do
    code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end

  desc 'Run all of the RSpec tests'
  task :run_rspec_tests => [:clear_coverage] # rubocop:disable Style/HashSyntax
  RSpec::Core::RakeTask.new(:run_rspec_tests, :command_options) do |t, args|
    t.rspec_opts = args[:command_options] || '--tag ~@wip --pattern "testing/rspec/spec/**/*_spec.rb" --force-color'
  end

  desc 'Run all of the Cucumber tests'
  task :run_cucumber_tests => [:clear_coverage] # rubocop:disable Style/HashSyntax
  task :run_cucumber_tests, [:command_options] do |_t, args|
    ENV['CUCUMBER_OPTS'] = args[:command_options] if args[:command_options]
  end
  Cucumber::Rake::Task.new(:run_cucumber_tests)

  desc 'Run all of the tests'
  task :test_everything => [:clear_coverage] do # rubocop:disable Style/HashSyntax
    puts Rainbow('Running RSpec tests...').cyan
    Rake::Task['cql:run_rspec_tests'].invoke
    puts Rainbow('All RSpec tests passing.').green

    puts Rainbow('Running Cucumber tests...').cyan
    Rake::Task['cql:run_cucumber_tests'].invoke
    puts Rainbow('All Cucumber tests passing.').green

    puts Rainbow('All tests passing! :)').green
  end

end

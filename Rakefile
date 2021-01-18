require 'bundler/gem_tasks'
require 'rake'
require 'coveralls/rake/task'
require 'cucumber/rake/task'
require 'rspec/core/rake_task'
require 'rainbow'


Rainbow.enabled = true


namespace 'cql' do

  desc 'Removes the current code coverage data'
  task :clear_coverage do
    code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end

  desc 'Check documentation with YARD'
  task :check_documentation do
    output = `yardoc`
    puts output

    if output =~ /100.00% documented/
      puts Rainbow('All code documented').green
    else
      raise Rainbow('Parts of the gem are undocumented').red
    end
  end

  desc 'Run all of the RSpec tests'
  task :run_rspec_tests => [:clear_coverage]
  RSpec::Core::RakeTask.new(:run_rspec_tests, :command_options) do |t, args|
    t.rspec_opts = args[:command_options] || '--tag ~@wip --pattern "testing/rspec/spec/**/*_spec.rb" --force-color'
  end

  desc 'Run all of the Cucumber tests'
  task :run_cucumber_tests => [:clear_coverage]
  task :run_cucumber_tests, [:command_options] do |_t, args|
    ENV['CUCUMBER_OPTS'] = args[:command_options] if args[:command_options]
  end
  Cucumber::Rake::Task.new(:run_cucumber_tests)

  desc 'Run all of the tests'
  task :test_everything => [:clear_coverage] do
    puts Rainbow('Running RSpec tests...').cyan
    Rake::Task['cql:run_rspec_tests'].invoke
    puts Rainbow('All RSpec tests passing.').green

    puts Rainbow('Running Cucumber tests...').cyan
    Rake::Task['cql:run_cucumber_tests'].invoke
    puts Rainbow('All Cucumber tests passing.').green

    puts Rainbow('All tests passing! :)').green
  end

  # Creates coveralls:push task
  Coveralls::RakeTask.new

  desc 'The task that CI will run. Do not run locally.'
  task :ci_build => ['cql:test_everything', 'coveralls:push']

  desc 'Check that things look good before trying to release'
  task :prerelease_check do
    begin
      Rake::Task['cql:test_everything'].invoke
      Rake::Task['cql:check_documentation'].invoke
    rescue => e
      puts Rainbow("Something isn't right!").red
      raise e
    end

    puts Rainbow('All is well. :)').green
  end

  # NOTE: There are currently no places to host the feature files but these tasks could be useful when there
  # are places again.

  # # Publishes the current feature file documentation to CucumberPro
  # desc 'Publish feature files to CucumberPro'
  # task :publish_to_cucumberpro do
  #   puts "Publishing features to CucumberPro..."
  #   `git push cucumber-pro`
  # end
  #
  # # Publishes the current feature file documentation to all places
  # desc 'Publish feature files to all documentation services'
  # task :publish_features => [:publish_to_cucumberpro]

end


task :default => 'cql:test_everything'

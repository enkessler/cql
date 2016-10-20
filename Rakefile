require "bundler/gem_tasks"
require 'coveralls/rake/task'

require 'racatt'


namespace 'cql' do

  task :clear_coverage do
    code_coverage_directory = "#{File.dirname(__FILE__)}/coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end


  Racatt.create_tasks

  # Redefining the task from 'racatt' in order to clear the code coverage results
  task :test_everything => :clear_coverage

  desc 'Test the project'
  task :smart_test do |t, args|
    rspec_args = '--tag ~@wip --pattern testing/rspec/spec/**/*_spec.rb'
    cucumber_args = 'testing/cucumber/features -r testing/cucumber/support -r testing/cucumber/step_definitions -f progress -t ~@wip'

    if Gem.loaded_specs['cuke_modeler'].version.version[/^0/]
      cucumber_args += ' -t ~@cuke_modeler_1x'
    end

    Rake::Task['cql:test_everything'].invoke(rspec_args, cucumber_args)
  end

  # The task that CI will use
  Coveralls::RakeTask.new
  task :ci_build => [:smart_test, 'coveralls:push']


  # The task used to publish the current feature file documentation to Relish
  desc 'Publish feature files to Relish'
  task :publish_features do
    # Get existing versions
    this_dir = File.dirname(__FILE__)
    output = `relish versions enkessler/cql`

    # Add the current version if it doesn't exist
    unless output =~ /#{Regexp.escape(CQL::VERSION)}/
      output = `relish versions:add enkessler/cql:#{CQL::VERSION}`
      puts output
    end

    # Publish the features
    output = `relish push enkessler/cql:#{CQL::VERSION} path #{this_dir}/testing/cucumber`
    puts output
  end

end


task :default => 'cql:smart_test'

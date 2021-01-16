require 'bundler/gem_tasks'
require 'rake'
require 'racatt'
require 'coveralls/rake/task'
require 'rainbow'


Rainbow.enabled = true

namespace 'racatt' do
  Racatt.create_tasks
end


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

  desc 'Run all of the tests'
  task :test_everything => [:clear_coverage] do
    rspec_args = '--tag ~@wip --pattern "testing/rspec/spec/**/*_spec.rb" --force-color'

    cucumber_version = Gem.loaded_specs['cucumber'].version.version
    cucumber_major_version = cucumber_version.match(/^(\d+)\./)[1].to_i
    cuke_modeler_major_version = Gem.loaded_specs['cuke_modeler'].version.version.match(/^(\d+)\./)[1].to_i

    cucumber_args = 'testing/cucumber/features'
    cucumber_args += ' -r testing/cucumber/support -r testing/cucumber/step_definitions'
    cucumber_args += ' -f progress --color'
    cucumber_args += if cucumber_major_version < 4
                       ' -t ~@wip'
                     else
                       " -t 'not @wip'"
                     end
    cucumber_args += ' -t ~@cuke_modeler_1x' if cuke_modeler_major_version == 0
    cucumber_args += ' --publish-quiet' if cucumber_major_version >= 5

    Rake::Task['racatt:test_everything'].invoke(rspec_args, cucumber_args)
  end

  # creates coveralls:push task
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

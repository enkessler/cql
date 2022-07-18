namespace 'cql' do

  desc 'Check that things look good before trying to release'
  task :prerelease_check do
    puts Rainbow('Checking that gem is in a good, releasable state...').cyan

    Rake::Task['cql:full_check'].invoke
    Rake::Task['cql:check_dependencies'].invoke

    puts Rainbow("I'd ship it. B)").green
  end

  desc 'Builds the gem and tags the current commit as a release commit'
  task :build_and_tag do
    puts Rainbow('Building gem for release...').cyan
    CQL::CQLHelper.run_command(['gem', 'build', 'cuke_modeler.gemspec'])

    release_tag = "v#{CQL::VERSION}"
    puts Rainbow("Tagging commit as '#{release_tag}'").cyan
    CQL::CQLHelper.run_command(['git', 'tag', release_tag])
  end

end

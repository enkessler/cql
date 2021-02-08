namespace 'cql' do

  desc 'Check that things look good before trying to release'
  task :prerelease_check do
    puts Rainbow('Checking that gem is in a good, releasable state...').cyan

    Rake::Task['cql:full_check'].invoke
    Rake::Task['cql:check_dependencies'].invoke

    puts Rainbow("I'd ship it. B)").green
  end

end

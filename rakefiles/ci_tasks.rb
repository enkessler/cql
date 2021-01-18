require 'coveralls/rake/task'

namespace 'cql' do

  # Creates coveralls:push task
  Coveralls::RakeTask.new

  desc 'The task that CI will run. Do not run locally.'
  task :ci_build => ['cql:test_everything', 'coveralls:push']

end

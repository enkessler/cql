require 'rubocop/rake_task'

namespace 'cql' do

  desc 'Generate a Rubocop report for the project'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.patterns = ['./']
    task.formatters = ['fuubar', ['html', '--out', 'rubocop.html']]
    task.options = ['-S']
  end

end

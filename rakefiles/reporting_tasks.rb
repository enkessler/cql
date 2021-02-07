namespace 'cql' do

  desc 'Removes the current code coverage data'
  task :clear_code_coverage do
    puts Rainbow('Clearing coverage directory...').cyan
    code_coverage_directory = "#{__dir__}/../coverage"

    FileUtils.remove_dir(code_coverage_directory, true)
  end

  desc 'Removes the contents of the test reporting directory'
  task :clear_report_directory do
    puts Rainbow('Clearing report directory...').cyan

    FileUtils.remove_dir(ENV['CQL_REPORT_FOLDER'], true)
    FileUtils.mkdir(ENV['CQL_REPORT_FOLDER'])
  end

  desc 'Removes existing test results and code coverage'
  task :clear_old_results => %i[clear_report_directory clear_code_coverage] # rubocop:disable Style/HashSyntax

end

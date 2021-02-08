SimpleCov.command_name(ENV['CQL_SIMPLECOV_COMMAND_NAME'])

SimpleCov.start do
  root __dir__
  coverage_dir "#{ENV['CQL_REPORT_FOLDER']}/coverage"

  add_filter '/testing/'
  add_filter '/environments/'
  add_filter 'cql_helper'

  merge_timeout 300
end

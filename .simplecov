require 'simplecov-lcov'

SimpleCov.command_name(ENV['CQL_SIMPLECOV_COMMAND_NAME'])

# Coveralls GitHub Action needs an lcov formatted file
SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.lcov_file_name = 'lcov.info'
end

# Also making a more friendly HTML file
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([SimpleCov::Formatter::HTMLFormatter,
                                                                SimpleCov::Formatter::LcovFormatter])

SimpleCov.start do
  root __dir__
  coverage_dir "#{ENV['CQL_REPORT_FOLDER']}/coverage"

  add_filter '/testing/'
  add_filter '/environments/'
  add_filter 'cql_helper'

  merge_timeout 300
end

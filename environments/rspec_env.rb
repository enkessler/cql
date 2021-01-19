ENV['CQL_SIMPLECOV_COMMAND_NAME'] ||= 'rspec_tests'

require 'simplecov'
require_relative 'common_env'

require 'rubygems/mock_gem_ui'

require_relative '../testing/cql_test_model'
require_relative '../testing/model_helper'
require_relative '../testing/helper_methods'
require_relative '../testing/rspec/spec/tag_filterable_specs'
require_relative '../testing/rspec/spec/name_filterable_specs'
require_relative '../testing/rspec/spec/line_count_filterable_specs'
require_relative '../testing/rspec/spec/line_filterable_specs'
require_relative '../testing/rspec/spec/queriable_specs'

CQL_FEATURE_FIXTURES_DIRECTORY = "#{__dir__}/../testing/fixtures/features".freeze

RSpec.configure do |config|

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include CQL::ModelHelper
  config.include CQL::HelperMethods
end

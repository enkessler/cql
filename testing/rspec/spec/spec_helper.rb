unless RUBY_VERSION.to_s < '1.9.0'
  require 'simplecov'
  SimpleCov.command_name('cql-rspec')
end


# Ruby 1.8.x seems to have trouble if relative paths get too nested, so resolving the path before using it here
this_dir = File.expand_path(File.dirname(__FILE__))
require "#{this_dir}/../../../lib/cql"


require "#{this_dir}/../../cql_test_model"
require "#{this_dir}/tag_filterable_specs"
require "#{this_dir}/name_filterable_specs"
require "#{this_dir}/line_count_filterable_specs"
require "#{this_dir}/line_filterable_specs"

CQL_FEATURE_FIXTURES_DIRECTORY = "#{this_dir}/../../fixtures/features"


RSpec.configure do |config|
  config.before(:all) do
    @feature_fixtures_directory = CQL_FEATURE_FIXTURES_DIRECTORY
  end

  config.before(:each) do
    # Nothing yet
  end

  config.after(:each) do
    # Nothing yet
  end
end



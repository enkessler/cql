require 'simplecov' unless RUBY_VERSION.to_s < '1.9.0'


require "#{File.dirname(__FILE__)}/../lib/cql"
require "#{File.dirname(__FILE__)}/tag_filterable_specs"
require "#{File.dirname(__FILE__)}/name_filterable_specs"
require "#{File.dirname(__FILE__)}/line_count_filterable_specs"
require "#{File.dirname(__FILE__)}/line_filterable_specs"

CQL_FEATURE_FIXTURES_DIRECTORY = "#{File.dirname(__FILE__)}/../fixtures/features"


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



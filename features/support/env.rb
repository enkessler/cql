unless RUBY_VERSION.to_s < '1.9.0'
  require 'simplecov'
  SimpleCov.command_name('cucumber_tests')
end


require File.dirname(__FILE__) + '/../../lib/cql'


Before do
  # Nothing yet
end

After do
  # Nothing yet
end



ENV['CQL_SIMPLECOV_COMMAND_NAME'] = 'cucumber_tests'

require 'simplecov'
require_relative 'common_env'

require 'tmpdir'

require_relative '../testing/cucumber/step_definitions/query_steps'
require_relative '../testing/cucumber/step_definitions/setup_steps'
require_relative '../testing/cucumber/step_definitions/verification_steps'


After do
  FileUtils.remove_dir(@temp_dir, true) if @temp_dir
end


def create_path(path)
  @temp_dir ||= Dir.mktmpdir
  path = path.sub('path/to/', "#{@temp_dir}/")

  Dir.mkdir(path)

  path
end

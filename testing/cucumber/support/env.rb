unless RUBY_VERSION.to_s < '1.9.0'
  require 'simplecov'
  SimpleCov.command_name('cql-cucumber')
end


require 'cql'
require 'cql/model_dsl'


Before do
  @default_file_directory = "#{File.dirname(__FILE__)}/../temp_files"

  FileUtils.mkdir(@default_file_directory)
end

After do
  FileUtils.remove_dir(@default_file_directory, true)
end


def process_path(path)
  path.sub('path/to', @default_file_directory)
end

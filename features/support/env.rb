unless RUBY_VERSION.to_s < '1.9.0'
  require 'simplecov'
  SimpleCov.command_name('cql-cucumber')
end

if RUBY_VERSION < '1.9.3'
  require 'backports/1.9.3/io/write'
end

if RUBY_VERSION < '1.9.2'
  require 'backports/1.9.2/array/select'
end

require 'cql'


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

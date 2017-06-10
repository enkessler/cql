unless RUBY_VERSION.to_s < '1.9.0'
  require 'simplecov'
  SimpleCov.command_name('cql-cucumber')
end

require 'tmpdir'

require 'cql'
require 'cql/model_dsl'


After do
  FileUtils.remove_dir(@temp_dir, true) if @temp_dir
end


def create_path(path)
  @temp_dir ||= Dir.mktmpdir
  path = path.sub('path/to/', "#{@temp_dir}/")

  Dir.mkdir(path)

  path
end

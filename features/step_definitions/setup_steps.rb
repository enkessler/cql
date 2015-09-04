Given(/^a directory "([^"]*)"$/) do |partial_directory_path|
  directory_path = "#{@default_file_directory}/#{partial_directory_path}"

  FileUtils.mkpath(directory_path) unless File.exists?(directory_path)
end

And(/^a file "([^"]*)":$/) do |partial_file_path, file_text|
  File.write("#{@default_file_directory}/#{partial_file_path}", file_text)
end

And(/^a repository is made from "([^"]*)"$/) do |partial_path|
  repo_path = "#{@default_file_directory}/#{partial_path}"

  @repository = CQL::Repository.new(repo_path)
end

Given(/^a directory "([^"]*)"$/) do |partial_directory_path|
  directory_path = partial_directory_path.include?('path/to') ? process_path(partial_directory_path) : "#{@default_file_directory}/#{partial_directory_path}"

  FileUtils.mkpath(directory_path) unless File.exists?(directory_path)
end

And(/^a file "([^"]*)":$/) do |partial_file_path, file_text|
  File.open("#{@default_file_directory}/#{partial_file_path}", 'w') { |file| file.write file_text }
end

And(/^a repository is made from "([^"]*)"$/) do |partial_path|
  repo_path = "#{@default_file_directory}/#{partial_path}"

  @repository = CQL::Repository.new(repo_path)
end

Given(/^the models provided by CukeModeler$/) do
  @available_model_classes = Array.new.tap do |classes|
    CukeModeler.constants.each do |constant|
      if CukeModeler.const_get(constant).is_a?(Class)
        classes << CukeModeler.const_get(constant) if CukeModeler.const_get(constant).ancestors.include?(CukeModeler::Model)
      end
    end
  end
end

Given(/^a repository to query$/) do
  @root_directory_model = CukeModeler::Directory.new
  @repository = CQL::Repository.new(@root_directory_model)
end

And(/^the following feature has been modeled in the repository:$/) do |text|
  file_model = CukeModeler::FeatureFile.new
  file_model.feature = CukeModeler::Feature.new(text)
  @root_directory_model.feature_files << file_model
end

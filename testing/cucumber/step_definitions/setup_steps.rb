Given(/^a directory "([^"]*)"$/) do |partial_directory_path|
  create_path(partial_directory_path)
end

Given(/^the models provided by CukeModeler$/) do
  @available_model_classes = [].tap do |classes|
    CukeModeler.constants.each do |constant|
      next unless CukeModeler.const_get(constant).is_a?(Class) &&
                  CukeModeler.const_get(constant).ancestors.include?(CukeModeler::Model)

      classes << CukeModeler.const_get(constant)
    end
  end
end

Given(/^a repository to query$/) do
  @root_directory_model = CukeModeler::Directory.new
  @repository = CQL::Repository.new(@root_directory_model)
end

And(/^the following feature has been modeled in the repository:$/) do |text|
  file_model = CukeModeler::FeatureFile.new

  # CukeModeler::FeatureFile had a different interface in 0.x
  if file_model.respond_to?(:feature=)
    file_model.feature = CukeModeler::Feature.new(text)
  else
    file_model.features << CukeModeler::Feature.new(text)
  end

  @root_directory_model.feature_files << file_model
end

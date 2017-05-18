Given(/^a directory "([^"]*)"$/) do |partial_directory_path|
  create_path(partial_directory_path)
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

  # CukeModeler::FeatureFile had a different interface in 0.x
  if file_model.respond_to?(:feature=)
    file_model.feature = CukeModeler::Feature.new(text)
  else
    file_model.features << CukeModeler::Feature.new(text)
  end

  @root_directory_model.feature_files << file_model
end

Given(/^a model for the following feature:$/) do |gherkin_text|
  @models ||= []
  @models << CukeModeler::Feature.new(gherkin_text)
end

Given(/^a model for the following scenario:$/) do |gherkin_text|
  @models ||= []
  @models << CukeModeler::Scenario.new(gherkin_text)
end

And(/^a model for the following outline:$/) do |gherkin_text|
  @models ||= []
  @models << CukeModeler::Outline.new(gherkin_text)
end

And(/^a repository that contains that model$/) do
  @root_directory_model = CukeModeler::Directory.new

  @models.each do |model|
    case
      when model.is_a?(CukeModeler::Feature)
        parent_model = CukeModeler::FeatureFile.new
        parent_model.feature = model
        @root_directory_model.feature_files << parent_model
      else
        raise(ArgumentError, "Don't know how to handle a #{model.class}")
    end
  end

  @repository = CQL::Repository.new(@root_directory_model)
end

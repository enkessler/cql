module CQL

  # A helper module for creating model trees used in testing
  module ModelHelper

    def directory_with(*models)
      directory_model = CukeModeler::Directory.new

      models.each do |model|
        case
          when model.is_a?(CukeModeler::Feature)
            file_model = CukeModeler::FeatureFile.new
            file_model.feature = model

            directory_model.feature_files << file_model
          else
            raise(ArgumentError, "Don't know how to handle a '#{model.class}'")
        end
      end

      directory_model
    end

  end
end

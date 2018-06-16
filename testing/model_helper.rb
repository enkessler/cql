module CQL
  module ModelHelper

    def directory_with(*models)
      directory_model = CukeModeler::Directory.new

      models.each do |model|
        case
          when model.is_a?(CukeModeler::Feature)
            file_model = CukeModeler::FeatureFile.new

            if Gem.loaded_specs['cuke_modeler'].version.version[/^0/]
              file_model.features = [model]
            else
              file_model.feature = model
            end

            directory_model.feature_files << file_model
          else
            raise(ArgumentError, "Don't know how to handle a '#{model.class}'")
        end
      end

      directory_model
    end

  end
end

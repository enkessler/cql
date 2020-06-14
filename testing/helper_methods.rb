module CQL
  module HelperMethods

    def cuke_modeler?(*versions)
      versions.include?(cuke_modeler_major_version)
    end

    def cuke_modeler_major_version
      Gem.loaded_specs['cuke_modeler'].version.version.match(/^(\d+)\./)[1].to_i
    end

  end
end

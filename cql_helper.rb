require 'childprocess'


module CQL

  # Various helper methods for the project
  module CQLHelper

    module_function

    def cuke_modeler?(*versions)
      versions.include?(cuke_modeler_major_version)
    end

    def cuke_modeler_major_version
      Gem.loaded_specs['cuke_modeler'].version.version.match(/^(\d+)\./)[1].to_i
    end

    def run_command(parts)
      parts.unshift('cmd.exe', '/c') if ChildProcess.windows?
      process = ChildProcess.build(*parts)

      process.io.inherit!
      process.start
      process.wait

      process
    end

  end
end

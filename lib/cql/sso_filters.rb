require 'cql/filters'


module CQL

  class SsoLineCountFilter < TypeCountFilter

    def type_count(test)
      test.steps.size
    end

  end

  class LineFilter < ContentMatchFilter

    def execute(input, negate)
      method_for_filtering = negate ? :reject : :select
      method_for_text = Gem.loaded_specs['cuke_modeler'].version.version[/^0/] ? :base : :text

      input.send(method_for_filtering) do |tests|
        raw_step_lines = tests.steps.map { |step| step.send(method_for_text) }

        content_match?(raw_step_lines)
      end
    end

  end

end

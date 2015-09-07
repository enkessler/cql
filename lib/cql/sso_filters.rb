require 'cql/filters'


module CQL

  class SsoTagCountFilter < TypeCountFilter

    def type_count(test)
      test.tags.size
    end

  end

  class SsoLineCountFilter < TypeCountFilter

    def type_count(test)
      test.steps.size
    end

  end

  class LineFilter < ContentMatchFilter

    def execute(input)
      input.find_all do |tests|
        raw_step_lines = tests.steps.map { |step| step.base }

        content_match?(raw_step_lines)
      end
    end

  end

end

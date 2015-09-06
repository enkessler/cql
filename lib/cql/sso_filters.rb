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

  class LineFilter
    attr_reader :line

    def initialize line
      @line = line
    end

    def execute input
      input.find_all do |sso|
        raw_step_lines = sso.steps.map { |sl| sl.base }
        result = nil

        if line.class == String
          result = raw_step_lines.any? { |step| step == line }
        elsif line.class == Regexp
          result = raw_step_lines.any? { |step| step =~ line }
        end

        result
      end
    end

  end

end

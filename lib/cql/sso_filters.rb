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
          result = raw_step_lines.include? line
        elsif line.class == Regexp
          result = filter_by_regexp(raw_step_lines)
        end

        result
      end
    end

    def filter_by_regexp(raw_step_lines)
      result = raw_step_lines.find { |l| l =~line }
      if result.class == String
        result = result.size > 0
      else
        result = false
      end
      result
    end
  end

end
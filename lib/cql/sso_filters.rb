module CQL

  class SsoTagCountFilter < Filter
    def execute input
      input.each_with_index do |feature, index|
        filtered_elements= feature.tests.find_all do |sso|
          sso.tags.size.send(comparison.operator, comparison.amount)
        end

        input[index].tests = filtered_elements
      end

      input
    end
  end

  class SsoTagFilter < TagFilter
    def execute input
      input.find_all do |sso|
        has_tags(sso.raw_element['tags'], tags)
      end
    end
  end

  class SsoLineCountFilter < Filter
    def execute input
      input.each_with_index do |feature, index|
        filtered_elements = feature.tests.find_all do |sso|
          sso.steps.size.send(comparison.operator, comparison.amount)
        end

        input[index].tests = filtered_elements
      end

      input
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
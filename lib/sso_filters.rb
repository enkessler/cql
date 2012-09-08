module CQL
  class LineFilter
    attr_reader :line

    def initialize line
      @line = line
    end

    def execute input
      input.each_with_index do |feature, index|
        filtered_elements= feature['elements'].find_all do |sso|
          raw_step_lines = sso['steps'].map { |sl| sl['name'] }
          result = nil
          if line.class == String
            result = raw_step_lines.include? line
          elsif line.class == Regexp
            result = filter_by_regexp(raw_step_lines)
          end
          result
        end
        input[index]['elements'] = filtered_elements
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
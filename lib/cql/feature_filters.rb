require 'cql/filters'


module CQL

  class TestCountFilter < TypeCountFilter

    def type_count(feature)
      feature.tests.find_all { |test| types.include?(test.class) }.size
    end

  end

end

require 'cql/filters'


module CQL

  # Not a part of the public API. Subject to change at any time.
  class TestCountFilter < TypeCountFilter

    def type_count(feature)
      feature.tests.find_all { |test| types.include?(test.class) }.size
    end

  end

end

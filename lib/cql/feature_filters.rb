require 'cql/filters'


module CQL

  class TestCountFilter < TypeCountFilter

    def type_count(feature)
      feature.tests.find_all { |test| types.include?(test.class) }.size
    end

  end

  class FeatureTagCountFilter < TypeCountFilter

    def type_count(feature)
      feature.tags.size
    end

  end

end

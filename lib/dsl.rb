module GQL
  module Dsl

    def names
      'names'
    end

    def features
      'features'
    end

    def scenario_outlines
      'scenario_outlines'
    end

    def file_names
      'uri'
    end

    def scenarios
      'scenarios'
    end

    def select what
      @what = what
    end

    def from where
      @from = where
      @data
    end

    def tag tag
       {'tag'=>tag}
    end

    def with filter
      @data = GQL::MapReduce.filter_features_by_tag(@data, filter['tag']) if filter.has_key? 'tag'
    end
  end

  class Query
    include Dsl
    attr_reader :data, :what

    def initialize features, &block
      @data = features
      @data = self.instance_eval(&block)
      results_map = {"uri-features" => GQL::MapReduce.uri(@data),
                     "names-features" => GQL::MapReduce.overview(@data),
                     "names-scenario_outlines" => GQL::MapReduce.get_all_scenario_outlines_from_feature(@data),
                     "names-scenarios" => GQL::MapReduce.get_scenarios_all_from_feature(@data)}
      @data = results_map[@what + "-" + @from]
    end
  end

end
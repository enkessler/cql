module GQL
  class Features

    class FilesNames
    end

    class Names
    end

    class Tag
      attr_reader :tag
      def initialize tag
        @tag = tag
      end
    end

    def names()
      Names.new
    end

    def file_names()
      FilesNames.new
    end

    def tag tag
      Tag.new(tag)
    end
  end

  class Scenarios
    class Names
    end

    def names()
      Names.new
    end
  end

  class ScenarioOutlines
    class Names
    end

    def names()
      Names.new
    end
  end

  module Dsl

    def select what
      @what = what
      @data
    end

    def apply_select data
      results_map = {"GQL::Features::FilesNames" => GQL::MapReduce.uri(data),
                     "GQL::Features::Names" => GQL::MapReduce.overview(data),
                     "GQL::ScenarioOutlines::Names" => GQL::MapReduce.get_all_scenario_outlines_from_feature(data),
                     "GQL::Scenarios::Names" => GQL::MapReduce.get_scenarios_all_from_feature(data)}
      results_map[@what.class.to_s]
    end

    def filter filter

      @data = GQL::MapReduce.filter_features_by_tag(@data, filter.tag)
    end

    def features()
      Features.new
    end

    def scenario_outlines()
      ScenarioOutlines.new
    end

    def scenarios()
      Scenarios.new
    end

  end

  class Query
    include Dsl
    attr_reader :data, :what

    def initialize features, &block
      @data = features
      @data = self.instance_eval(&block)
      results_map = {"GQL::Features::FilesNames" => GQL::MapReduce.uri(@data),
                     "GQL::Features::Names" => GQL::MapReduce.overview(@data),
                     "GQL::ScenarioOutlines::Names" => GQL::MapReduce.get_all_scenario_outlines_from_feature(@data),
                     "GQL::Scenarios::Names" => GQL::MapReduce.get_scenarios_all_from_feature(@data)}
      @data = results_map[@what.class.to_s]
    end
  end

end
module GQL
  class Features

    class FilesNames
    end

    class Names
    end

    def names()
      Names.new
    end

    def file_names()
      FilesNames.new
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
      results_map = {"GQL::Features::FilesNames" => physical_feature_files,
                     "GQL::Features::Names" => GQL::MapReduce.overview(parsed_feature_files),
                     "GQL::ScenarioOutlines::Names" => GQL::MapReduce.get_all_scenario_outlines_from_feature(parsed_feature_files),
                     "GQL::Scenarios::Names" => GQL::MapReduce.get_scenarios_all_from_feature(parsed_feature_files)}
      results_map[what.class.to_s]
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

    def query &block
      instance_eval(&block)
    end
  end
end
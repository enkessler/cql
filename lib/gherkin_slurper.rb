require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'json'
require 'set'

module GQL
  class Features

    class FilesNames
    end

    class Names
    end

    def names() Names.new end
    def file_names() FilesNames.new end
  end

  class Scenarios
    class Names
    end

    def names() Names.new end
  end

  class ScenarioOutlines
    class Names
    end

    def names() Names.new end
  end

  module Dsl
    def select what
      results_map = {"GQL::Features::FilesNames" => physical_feature_files,
       "GQL::Features::Names" => GQL::MapReduce.overview(parsed_feature_files),
       "GQL::ScenarioOutlines::Names" => GQL::MapReduce.get_all_scenario_outlines_from_feature(parsed_feature_files),
       "GQL::Scenarios::Names" => GQL::MapReduce.get_scenarios_all_from_feature(parsed_feature_files)}
      results_map[what.class.to_s]
    end

    def features() Features.new end
    def scenario_outlines() ScenarioOutlines.new end
    def scenarios() Scenarios.new end

    def query &block
      instance_eval(&block)
    end
  end

  class MapReduce

    def self.overview input
      input.map { |a| a['name'] }
    end

    def self.find_feature input, feature_to_find
      feature_found = nil
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature_found = feature
        end
      end
      feature_found
    end

    def self.get_scenario input, feature_to_find, scenario_to_find
      scenario = nil
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenario = element if element['name'] == scenario_to_find
          end
        end
      end
      scenario
    end

    def self.tags input
      tags = Set.new
      input.each do |feature|
        feature['elements'].each do |element|
          if element['tags'] != nil
            element['tags'].each do |tag|
              tags.add tag['name']
            end
          end
        end
      end
      tags.to_a
    end

    def self.get_scenarios_from_feature input, feature_to_find
      scenarios = []
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario"
          end
        end
      end
      scenarios
    end

    def self.get_scenarios_all_from_feature input
      scenarios = []
      input.each do |feature|
        feature['elements'].each do |element|
          scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario"
        end
      end
      scenarios
    end

    def self.get_scenario_outlines_from_feature input, feature_to_find
      scenarios = []
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario_outline"
          end
        end
      end
      scenarios
    end

    def self.get_all_scenario_outlines_from_feature input
      scenarios = []
      input.each do |feature|

        feature['elements'].each do |element|
          scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario_outline"
        end

      end
      scenarios
    end

    def self.get_scenario_by_feature_and_tag input, feature_to_find, *tags_to_find
      scenarios = []
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            if (element['name'] != "") and element['type'] == "scenario" and element['tags'] != nil and has_tags(element['tags'], tags_to_find)
              scenarios.push element['name']
            end
          end
        end
      end
      scenarios
    end

    def self.has_tags tags_given, tags_for_search
      tags_given = tags_given.map { |t| t["name"] }
      found = 0
      tags_for_search.each do |tag_for_search|
        found = found + 1 if tags_given.include?(tag_for_search)
      end
      found == tags_for_search.size
    end
  end

  class GherkinRepository
    include Dsl
    attr_reader :physical_feature_files, :parsed_feature_files

    def initialize features_home_dir
      @physical_feature_files = list_features(features_home_dir)
      @parsed_feature_files = load_features @physical_feature_files
    end

    def list_features base_dir
      Dir.glob(base_dir + "/**/*.feature")
    end

    def load_features sources
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      sources.each { |s| parser.parse(IO.read(s), s, 0) }
      formatter.done
      JSON.parse(io.string)
    end
  end
end
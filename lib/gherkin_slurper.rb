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
       "GQL::Features::Names" => overview,
       "GQL::ScenarioOutlines::Names" => get_all_scenario_outlines_from_feature,
       "GQL::Scenarios::Names" => get_scenarios_all_from_feature}
      results_map[what.class.to_s]
    end

    def features() Features.new end
    def scenario_outlines() ScenarioOutlines.new end
    def scenarios() Scenarios.new end

    def query &block
      instance_eval(&block)
    end
  end

  module Query

    def overview
      @parsed_feature_files.map { |a| a['name'] }
    end

    def list_features base_dir
      Dir.glob(base_dir + "/**/*.feature")
    end

    def find_feature feature_to_find
      feature_found = nil
      @parsed_feature_files.each do |feature|
        if feature['name'] == feature_to_find
          feature_found = feature
        end
      end
      feature_found
    end

    def get_scenario feature_to_find, scenario_to_find
      scenario = nil
      @parsed_feature_files.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenario = element if element['name'] == scenario_to_find
          end
        end
      end
      scenario
    end

    def tags
      tags = Set.new
      @parsed_feature_files.each do |feature|
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

    def get_scenarios_from_feature feature_to_find
      scenarios = []
      @parsed_feature_files.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario"
          end
        end
      end
      scenarios
    end

    def get_scenarios_all_from_feature
      scenarios = []
      @parsed_feature_files.each do |feature|
        feature['elements'].each do |element|
          scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario"
        end
      end
      scenarios
    end

    def get_scenario_outlines_from_feature feature_to_find
      scenarios = []
      @parsed_feature_files.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario_outline"
          end
        end
      end
      scenarios
    end

    def get_all_scenario_outlines_from_feature
      scenarios = []
      @parsed_feature_files.each do |feature|

        feature['elements'].each do |element|
          scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario_outline"
        end

      end
      scenarios
    end

    def get_scenario_by_feature_and_tag feature_to_find, *tags_to_find
      scenarios = []
      @parsed_feature_files.each do |feature|
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

    def has_tags tags_given, tags_for_search
      tags_given = tags_given.map { |t| t["name"] }
      found = 0
      tags_for_search.each do |tag_for_search|
        found = found + 1 if tags_given.include?(tag_for_search)
      end
      found == tags_for_search.size
    end
  end

  class GherkinSlurper
    include Query
    include Dsl
    attr_reader :physical_feature_files, :parsed_feature_files

    def initialize features_home_dir
      @physical_feature_files = list_features(features_home_dir)
      @parsed_feature_files = load_features @physical_feature_files
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
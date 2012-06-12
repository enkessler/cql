require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'json'
require 'set'

module BDD
  class GherkinSlurper
    attr_reader :physical_feature_files, :parsed_feature_files

    def initialize features_home_dir
      @physical_feature_files = list_features(features_home_dir)
      @parsed_feature_files = load_features @physical_feature_files
    end

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

    def get_scenario_by_feature_and_tag feature_to_find, tag_to_find
      scenarios = []
      @parsed_feature_files.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            if (element['name'] != "") and element['type'] == "scenario" and element['tags'] != nil and tags_count(element['tags'], tag_to_find) > 0
              scenarios.push element['name']
            end
          end
        end
      end
      scenarios
    end

    def tags_count tags, search
      found = 0
      tags.map { |e| found = found + 1 if e['name'] == search }
      found
    end

    def load_features sources
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)

      sources.each do |s|
        parser.parse(IO.read(s), s, 0)
      end

      formatter.done
      JSON.parse(io.string)
    end
  end
end
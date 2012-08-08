require File.dirname(__FILE__) + "/dsl"
require 'set'
module CQL

  QUERY_VALUES = %w(name uri line description type steps id tags examples)

  class MapReduce

    CQL::QUERY_VALUES.each do |property|
      define_singleton_method(property) do |input|
        input = [input] if input.class != Array
        input.map { |a| a[property] }
      end
    end

    %w(all everything complete).each do |method_name|
      define_singleton_method(method_name) { |input| input }
    end

    def self.step_lines input
      input = [input] if input.class != Array
      steps(input).map do |scen|
        scen.map { |line| line['keyword'] + line['name'] }
      end
    end

    def self.filter_features input, args
      if args.has_key?('feature') && args['feature'][0].class == String
        input = input.find_all { |feature| feature['name'] == args['feature'][0] }
      elsif args.has_key?('feature') && args['feature'][0].class == Regexp
        input = input.find_all { |feature| feature['name'] =~ args['feature'][0] }
      elsif args.has_key?('sc_gt')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario" }.size > args['sc_gt']
        end
      elsif args.has_key?('sc_gte')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario" }.size >= args['sc_gte']
        end
      elsif args.has_key?('sc_lt')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario" }.size < args['sc_lt']
        end
      elsif args.has_key?('sc_lte')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario" }.size <= args['sc_lte']
        end
      elsif args.has_key?('soc_gt')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario Outline" }.size > args['soc_gt']
        end
      elsif args.has_key?('soc_gte')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario Outline" }.size >= args['soc_gte']
        end
      elsif args.has_key?('soc_lt')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario Outline" }.size < args['soc_lt']
        end
      elsif args.has_key?('soc_lte')
        input = input.find_all do |feature|
          feature['elements'].find_all { |e| e['keyword'] == "Scenario Outline" }.size <= args['soc_lte']
        end
      end

      input = input.find_all { |feature| has_tags feature['tags'], args['tags'] } if args.has_key? 'tags'
      input
    end

    def self.filter_sso input, args
      results = []
      input = filter_features(input, 'feature'=>args['feature']) if args.has_key?('feature')
      input.each do |feature|
        feature['elements'].each do |element|
          results.push element if element['type'] == args['what']
        end
      end
      results
    end

    def self.tag_set input
      tags = Set.new
      input.each do |feature|
        feature['elements'].each do |element|
          break if element['tags'] == nil
          element['tags'].each { |tag| tags.add tag['name'] }
        end
      end
      tags.to_a
    end

    def self.has_tags given, search
      return false if given == nil
      search.count { |tag_for_search| given.map { |t| t["name"] }.include?(tag_for_search) }==search.size
    end

  end
end
require File.dirname(__FILE__) + "/dsl"
require 'pp'
module CQL

  QUERY_VALUES = %w(name uri line description type steps id)

  class MapReduce

    CQL::QUERY_VALUES.each do |property|
      define_singleton_method (property) do |input|
        input.class == Array ? input.map { |a| a[property] } : input[property]
      end
    end

    def self.step_lines input
      result = steps(input).map do |scen|
        scen.map { |line| line['keyword'] + line['name'] }
      end
    end

    def self.filter_features input, args
      input = input.find_all { |feature| feature['name'] == args['feature'] } if args.has_key? 'feature'
      input = input.find_all { |feature| has_tags feature['tags'], args['tags'] } if args.has_key? 'tags'
      if input.size == 1
        input = input.first
      end
      input
    end

    def self.filter_sso input, args
      results = []
      input = [filter_features(input, 'feature'=>args['feature'])] if args.has_key?('feature')
      input.each do |feature|
        feature['elements'].each do |element|
          results.push element if element['type'] == args['what']
        end
      end
      results
    end

    def self.tags input
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
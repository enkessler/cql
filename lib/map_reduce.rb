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
      end

      %w(sc_gt sc_gte sc_lt sc_lte soc_gt soc_gte soc_lt soc_lte ssoc_gt ssoc_gte ssoc_lt ssoc_lte).each do |fn|
        if args.has_key?(fn)
          what, operator = fn.split "_"
          desc = {"sc"=>["Scenario"], "soc"=>["Scenario Outline"], "ssoc"=>["Scenario", "Scenario Outline"]}
          operator_map = {"lt"=>'<', 'lte'=>'<=', 'gt'=>'>', 'gte'=>'>='}
          input = input.find_all do |feature|
            size = feature['elements'].find_all { |e| desc[what].include? e['keyword'] }.size
            size.send(operator_map[operator], args[fn])
          end
        end
      end

      %w(tc_lt).each do |fn|
        what, operator = fn.split "_"
        operator_map = {"lt"=>'<', 'lte'=>'<=', 'gt'=>'>', 'gte'=>'>='}
        if args.has_key?(fn)
          input = input.find_all do |feature|
            feature['tags'] && feature['tags'].size < args['tc_lt']
          end
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
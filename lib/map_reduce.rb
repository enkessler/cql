require 'set'
require File.dirname(__FILE__) + "/dsl"
require File.dirname(__FILE__) + "/handlers"
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
      if args.class == CQL::Dsl::NameFilter
        if args.name.class == String
          input = input.find_all { |feature| feature['name'] == args.name }
        elsif args.name.class == Regexp
          input = input.find_all { |feature| feature['name'] =~ args.name }
        end
      elsif args.class == CQL::Dsl::Filter && args.type != 'tc'
        input = input.find_all do |feature|
          size = feature['elements'].find_all { |e| args.full_type.include? e['keyword'] }.size
          size.send(args.comparison.operator, args.comparison.amount)
        end
      elsif args.class == CQL::Dsl::Filter && args.type == 'tc'
        input = input.find_all do |feature|
          feature['tags'] && feature['tags'].size.send(args.comparison.operator, args.comparison.amount)
        end
      elsif args.class == CQL::Dsl::TagFilter
        input = input.find_all { |feature|
          has_tags feature['tags'], args.tags
        }
      end

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

    def self.filter_sso2 input, args
      if args.class == CQL::Dsl::Filter and args.type == 'tc'
        input.each_with_index do |feature, index|
          filtered_elements= feature['elements'].find_all do |sso|
            sso['tags'].size.send(args.comparison.operator, args.comparison.amount)
          end
          input[index]['elements'] = filtered_elements
        end
        return input
      elsif args.class == CQL::Dsl::Filter and args.type == 'lc'

        input.each_with_index do |feature, index|
          filtered_elements= feature['elements'].find_all do |sso|
            sso['steps'].size.send(args.comparison.operator, args.comparison.amount)
          end
          input[index]['elements'] = filtered_elements
        end
        return input

      else
        SsoHandlerChain.new.handle(args, input)
      end
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
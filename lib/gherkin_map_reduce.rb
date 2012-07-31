module GQL
  class MapReduce

    def self.overview input
      input.map{|a| a['name'] }
    end

    def self.uri input
      input.map{|a| a['uri'] }
    end

    def self.find_feature input, feature_to_find
      input.find{|feature| feature['name'] == feature_to_find }
    end

    def self.filter_features_by_tag input, *tags_to_find
      input.find_all{|feature| has_tags feature['tags'], tags_to_find.flatten }
    end

    def self.scenario_by_feature_and_tag input, feature_to_find, condition, *tags_to_find
      scenarios = []
      input.each do |feature|
        if feature['name'] == feature_to_find
          feature['elements'].each do |element|
            if element['type'] == "scenario" and has_tags(element['tags'], tags_to_find) == condition
              scenarios.push element['name']
            end
          end
        end
      end
      scenarios
    end

    def self.scenario input, feature_to_find, scenario_to_find
      input = find_feature input, feature_to_find
      input['elements'].find{|element|element['name'] == scenario_to_find }
    end

    def self.all input, args
      results = []
      input = [find_feature(input, args['feature'])] if args.has_key?('feature')
      input.each do |feature|
        feature['elements'].each do |element|
          results.push element['name'] if element['type'] == args['what']
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
      search.count{|tag_for_search| given.map{|t| t["name"]}.include?(tag_for_search)}==search.size
    end
  end
end
module GQL
  class MapReduce

    def self.overview input
      input.map { |a| a['name'] }
    end

    def self.uri input
      input.map { |a| a['uri'] }
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
      input = find_feature input, feature_to_find
      scenario = nil
      input['elements'].each { |element| scenario = element if element['name'] == scenario_to_find }
      scenario
    end

    def self.filter_features_by_tag input, *tags_to_find
      features = []
      input.each do |feature|
          if (feature['tags'] != nil  and has_tags(feature['tags'], tags_to_find.flatten))
            features.push feature
          end
      end
      features
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
      input = find_feature input, feature_to_find
      input['elements'].each do |element|
        scenarios.push element['name'] if (element['name'] != "") and element['type'] == "scenario"
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
end
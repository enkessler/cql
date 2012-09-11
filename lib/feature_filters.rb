module CQL
  class NameFilter
    attr_reader :name

    def initialize name
      @name = name
    end

    def execute input
      if name.class == String
        input = input.find_all { |feature| feature['name'] == name }
      elsif name.class == Regexp
        input = input.find_all { |feature| feature['name'] =~ name }
      end
      input
    end
  end

  class Filter
    attr_reader :type, :comparison

    def initialize type, comparison
      @type = type
      @comparison = comparison
    end

    def full_type
      {"sc"=>["Scenario"], "soc"=>["Scenario Outline"], "ssoc"=>["Scenario", "Scenario Outline"]}[@type]
    end

    def execute input
      input.find_all do |feature|
        size = feature['elements'].find_all { |e| full_type.include? e['keyword'] }.size
        size.send(comparison.operator, comparison.amount)
      end
    end

  end

  class FeatureTagCountFilter < Filter
    def execute input
      input.find_all do |feature|
        feature['tags'] && feature['tags'].size.send(comparison.operator, comparison.amount)
      end
    end
  end

  class TagFilter
    attr_reader :tags

    def initialize tags
      @tags = tags
    end

    def has_tags given, search
      return false if given == nil
      search.count do |tag_for_search|
        given.map { |t| t["name"] }.include?(tag_for_search)
      end ==search.size
    end
  end

  class FeatureTagFilter < TagFilter
    def initialize tags
      super tags
    end

    def execute input
      input.find_all { |feature| has_tags feature['tags'], tags }
    end
  end

end
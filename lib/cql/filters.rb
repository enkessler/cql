module CQL

  class TagFilter
    attr_reader :tags

    def initialize tags
      @tags = tags
    end

    def has_tags?(object, tags)
      tags.all? { |tag| object.tags.include?(tag) }
    end

    def execute objects
      objects.find_all { |object| has_tags?(object, tags) }
    end

  end

  class NameFilter
    attr_reader :name

    def initialize name
      @name = name
    end

    def execute input
      if name.class == String
        filtered_objects = input.find_all { |feature| feature.name == name }
      elsif name.class == Regexp
        filtered_objects = input.find_all { |feature| feature.name =~ name }
      end

      filtered_objects
    end
  end

  class TypeCountFilter
    attr_reader :types, :comparison

    def initialize types, comparison
      @types = types
      @comparison = comparison
    end

    def execute input
      input.find_all do |object|
        type_count(object).send(comparison.operator, comparison.amount)
      end
    end

  end

end

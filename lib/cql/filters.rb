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

  class ContentMatchFilter
    attr_reader :pattern

    def initialize(pattern)
      @pattern = pattern
    end

    def content_match?(content)
      if pattern.is_a?(String)
        content.any? { |thing| thing == pattern }
      elsif pattern.is_a?(Regexp)
        content.any? { |thing| thing =~ pattern }
      else
        # todo - Raise exception?
        false
      end
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

  class NameFilter < ContentMatchFilter

    def execute(input)
      input.find_all do |object|
        content_match?([object.name])
      end
    end

  end

  class TagCountFilter < TypeCountFilter

    def type_count(test)
      test.tags.size
    end

  end

end

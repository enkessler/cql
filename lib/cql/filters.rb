module CQL

  # Not a part of the public API. Subject to change at any time.
  class TagFilter
    attr_reader :tags

    def initialize tags
      @tags = tags
    end

    def has_tags?(object, target_tags)
      target_tags.all? { |target_tag|
        tags = object.tags
        tags = tags.collect { |tag| tag.name } unless Gem.loaded_specs['cuke_modeler'].version.version[/^0/]
        tags.include?(target_tag)
      }
    end

    # Filters the input models so that only the desired ones are returned
    def execute(objects, negate)
      method = negate ? :reject : :select

      objects.send(method) { |object| has_tags?(object, tags) }
    end

  end

  # Not a part of the public API. Subject to change at any time.
  class ContentMatchFilter
    attr_reader :pattern

    def initialize(pattern)
      raise(ArgumentError, "Can only match a String or Regexp. Got #{pattern.class}.") unless pattern.is_a?(String) || pattern.is_a?(Regexp)

      @pattern = pattern
    end

    def content_match?(content)
      if pattern.is_a?(String)
        content.any? { |thing| thing == pattern }
      else
        content.any? { |thing| thing =~ pattern }
      end
    end

  end

  # Not a part of the public API. Subject to change at any time.
  class TypeCountFilter
    attr_reader :types, :comparison

    def initialize types, comparison
      @types = types
      @comparison = comparison
    end

    # Not a part of the public API. Subject to change at any time.
    # Filters the input models so that only the desired ones are returned
    def execute(input, negate)
      method = negate ? :reject : :select

      input.send(method) do |object|
        type_count(object).send(comparison.operator, comparison.amount)
      end
    end

  end

  # Not a part of the public API. Subject to change at any time.
  class NameFilter < ContentMatchFilter

    # Filters the input models so that only the desired ones are returned
    def execute(input, negate)
      method = negate ? :reject : :select

      input.send(method) do |object|
        content_match?([object.name])
      end
    end

  end


  # Not a part of the public API. Subject to change at any time.
  class TagCountFilter < TypeCountFilter

    # Counts the numbers of tags on a test
    def type_count(test)
      test.tags.size
    end

  end

end

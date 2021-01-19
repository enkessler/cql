module CQL

  # Not a part of the public API. Subject to change at any time.
  class TagFilter

    # Tags to match
    attr_reader :tags

    # Creates a new filter
    def initialize(tags)
      @tags = tags
    end

    # Returns whether or not the object has the target tags
    def tags?(object, target_tags)
      target_tags.all? do |target_tag|
        tags = object.tags.map(&:name)
        tags.include?(target_tag)
      end
    end

    # Filters the input models so that only the desired ones are returned
    def execute(objects, negate)
      method = negate ? :reject : :select

      objects.send(method) { |object| tags?(object, tags) }
    end

  end

  # Not a part of the public API. Subject to change at any time.
  class ContentMatchFilter

    # Pattern to match
    attr_reader :pattern

    # Creates a new filter
    def initialize(pattern)
      raise(ArgumentError, "Can only match a String or Regexp. Got #{pattern.class}.") unless pattern.is_a?(String) || pattern.is_a?(Regexp)

      @pattern = pattern
    end

    # Returns whether or not the content matches the pattern
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


    attr_reader :types,     # the types of object that will be filtered against
                :comparison # the comparison that will be made between the objects

    # Creates a new filter
    def initialize(types, comparison)
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

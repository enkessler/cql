module CukeModeler

  # A simple model for testing purposes
  class CqlTestModel

    attr_accessor :attribute_1
    attr_accessor :attribute_2
    attr_accessor :attribute_3

    def children
      @children ||= []

      @children
    end

  end

end

module CukeModeler

  # Just a similarly named class for testing shorthand name matching
  class CqlTestModels

    attr_accessor :attribute_1
    attr_accessor :attribute_2
    attr_accessor :attribute_3

    def children
      @children ||= []

      @children
    end

  end

end

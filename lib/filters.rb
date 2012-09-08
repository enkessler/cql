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

end
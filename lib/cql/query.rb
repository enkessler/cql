module CQL

  # Not a part of the public API. Subject to change at any time.
  class Query

    include Dsl


    attr_reader :data, # the root object that will be queried
                :what  # what kinds of objects will be selected

    # Creates a new query object
    def initialize(directory, &block)
      # Set root object
      @data = directory

      # Populate configurables from DSL block
      instance_eval(&block)


      raise(ArgumentError, "A query must specify a 'select' clause") unless @what
      raise(ArgumentError, "A query must specify a 'from' clause") unless @from

      warn("Multiple selections made without using an 'as' clause") unless @name_transforms || (@what.count == @what.uniq.count)

      # Gather relevant objects from root object and filters
      @data = CQL::MapReduce.gather_objects(@data, @from, @filters)

      # Extract properties from gathered objects
      @data = format_output(@data)
    end


    private


    def format_output(data)
      format_data(data)
    end

    def format_data(data)
      space_data

      [].tap do |result_array|
        data.each do |element|
          result_array << {}.tap do |result|
            @what.each_with_index do |attribute, index|
              key = determine_key(attribute, index)
              value = determine_value(element, attribute, index)

              result[key] = value
            end
          end
        end
      end
    end

    def determine_key(attribute, index)
      key = mapped_attribute(@name_transforms, attribute, index) if @name_transforms

      key || attribute
    end

    def determine_value(element, attribute, index)
      original_value = attribute.is_a?(Symbol) ? determine_special_value(element, attribute) : determine_normal_value(element, attribute)

      if @value_transforms
        value = mapped_attribute(@value_transforms, attribute, index)
        value = value.call(original_value) if value.is_a?(Proc)
      end

      value || original_value
    end

    def determine_special_value(element, attribute)
      # TODO: Not sure what other special values to have but this could be expanded upon later.
      case attribute
        when :self, :model
          val = element
        else
          raise(ArgumentError, ":#{attribute} is not a valid attribute for selection.")
      end

      val
    end

    def determine_normal_value(element, attribute)
      raise(ArgumentError, "'#{attribute}' is not a valid attribute for selection from a '#{element.class}'.") unless element.respond_to?(attribute)

      element.send(attribute)
    end

    def mapped_attribute(mappings, attribute, location)
      case
        when mappings.is_a?(Array)
          value = mappings[location]
        when mappings.is_a?(Hash)
          value = mappings[attribute][location] if mappings[attribute]
        else
          raise(ArgumentError, "Unknown mapping type '#{mappings.class}'")
      end

      value
    end

    def space_data
      space_renamings
      space_transforms
    end

    def space_renamings
      return unless @name_transforms.is_a?(Hash)

      new_names = {}

      @name_transforms.each_pair do |key, value|
        new_names[key] = []

        @what.each do |attribute|
          new_names[key] << (attribute == key ? value.shift : nil)
        end
      end

      @name_transforms = new_names
    end

    def space_transforms
      return unless @value_transforms.is_a?(Hash)

      new_values = {}

      @value_transforms.each_pair do |key, value|
        new_values[key] = []

        @what.each do |attribute|
          new_values[key] << (attribute == key ? value.shift : nil)
        end
      end

      @value_transforms = new_values
    end

  end
end

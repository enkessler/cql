require 'cuke_modeler'
require 'cql/map_reduce'

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_data data
      space_data

      Array.new.tap do |result_array|
        data.each do |element|
          result_array << Hash.new.tap do |result|
            @what.each_with_index do |attribute, index|
              key = determine_key(attribute, index)
              value = determine_value(element, attribute, index)

              result[key] = value
            end
          end
        end
      end

    end

    def initialize(directory, &block)
      # Set root object
      @data = directory

      # Populate configurables from DSL block
      self.instance_eval(&block)


      raise(ArgumentError, "A query must specify a 'select' clause") unless @what
      raise(ArgumentError, "A query must specify a 'from' clause") unless @from


      # Gather relevant objects from root object and filters
      @data = CQL::MapReduce.gather_objects(@data, @from, @filters)

      # Extract properties from gathered objects
      @data = format_output(@data)
    end


    private


    def format_output(data)
      format_data(data)
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
      # todo - Not sure what other special values to have but this could be expanded upon later.
      case attribute
        when :self, :model
          val = element
        else
          raise(ArgumentError, ":#{attribute} is not a valid attribute for selection.")
      end

      val
    end

    def determine_normal_value(element, attribute)
      if element.respond_to?(attribute)
        element.send(attribute)
      else
        raise(ArgumentError, "'#{attribute}' is not a valid attribute for selection from a '#{element.class}'.")
      end
    end

    def mapped_attribute(mappings, attribute, location)
      case
        when mappings.is_a?(Array)
          value = mappings[location]
        when mappings.is_a?(Hash)
          if mappings[attribute]
            value = mappings[attribute][location]
          end
        else
          # todo - add error message
      end

      value
    end

    def space_data
      space_renamings
      space_transforms
    end

    def space_renamings
      if @name_transforms.is_a?(Hash)
        new_names = {}

        @name_transforms.each_pair do |key, value|
          new_names[key] = []

          @what.each do |attribute|
            if attribute == key
              new_names[key] << value.shift
            else
              new_names[key] << nil
            end
          end
        end

        @name_transforms = new_names
      end
    end

    def space_transforms
      if @value_transforms.is_a?(Hash)
        new_values = {}

        @value_transforms.each_pair do |key, value|
          new_values[key] = []

          @what.each do |attribute|
            if attribute == key
              new_values[key] << value.shift
            else
              new_values[key] << nil
            end
          end
        end

        @value_transforms = new_values
      end
    end

  end


  class Repository

    def initialize(repository_root)
      case
        when repository_root.is_a?(String)
          @root = CukeModeler::Directory.new(repository_root)
        when repository_root.class.to_s =~ /CukeModeler/
          @root = repository_root
        else
          raise(ArgumentError, "Don't know how to make a repository from a #{repository_root.class}")
      end
    end

    def query &block
      Query.new(@root, &block).data
    end

  end
end

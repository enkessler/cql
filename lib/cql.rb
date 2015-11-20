require 'cuke_modeler'
require 'cql/dsl'

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_data data
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

      # Gather relevant objects from root object and filters
      @data= CQL::MapReduce.gather_objects(@data, @from, @filters)

      # Extract properties from gathered objects
      @data= format_output(@data)
    end


    private


    def format_output(data)
      format_data(data)
    end

    def determine_key(attribute, index)
      key = transform_stuff(@name_transforms, attribute, index) if @name_transforms

      key || attribute
    end

    def determine_value(element, attribute, index)
      original_value = attribute.is_a?(Symbol) ? special_value(element, attribute) : element.send(attribute)

      if @value_transforms
        value = transform_stuff(@value_transforms, attribute, index)
        value = value.call(original_value) if value.is_a?(Proc)
      end

      value || original_value
    end

    def special_value(element, attribute)
      # todo - Not sure what other special values to have but this could be expanded upon later.
      case attribute
        when :self
          val = element
        else
          # todo - error message?
      end

      val
    end

    def transform_stuff(transforms, attribute, location)
      case
        when transforms.is_a?(Array)
          value = transforms[location]
        when transforms.is_a?(Hash)
          if transforms[attribute]
            value = transforms[attribute].first
            rotate_array(transforms[attribute])
          end
        else
          # todo - add error message
      end

      value
    end

    def rotate_array(array)
      return if array.empty?

      first = array.shift

      array << first
    end

  end


  class Repository

    def initialize(repository_root)
      case
        when repository_root.is_a?(String)
          @target_directory = CukeModeler::Directory.new(repository_root)
        when repository_root.class.to_s =~ /CukeModeler/
          @target_directory = repository_root
        else
          raise(ArgumentError, "Don't know how to make a repository from a #{repository_root.class}")
      end
    end

    def query &block
      # A quick 'deep clone'
      new_repo = Marshal::load(Marshal.dump(@target_directory))

      Query.new(new_repo, &block).data
    end

  end
end

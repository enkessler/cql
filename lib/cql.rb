if RUBY_VERSION < '1.9.2'
  require 'backports/1.9.2/array/rotate'
end

require 'cuke_modeler'
require 'cql/dsl'

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_data data
      return data if @what.empty?

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
      original_value = element.send(attribute)

      if @value_transforms
        value = transform_stuff(@value_transforms, attribute, index)
        value = value.call(original_value) if value.is_a?(Proc)
      end

      value || original_value
    end

    def transform_stuff(transforms, attribute, location)
      case
        when transforms.is_a?(Array)
          value = transforms[location]
        when transforms.is_a?(Hash)
          if transforms[attribute]
            value = transforms[attribute].first
            transforms[attribute].rotate!
          end
        else
          # todo - add error message
      end

      value
    end

  end


  class Repository

    def initialize features_home_dir
      @target_directory = CukeModeler::Directory.new(features_home_dir)
    end

    def query &block
      # A quick 'deep clone'
      new_repo = Marshal::load(Marshal.dump(@target_directory))

      final_output = Query.new(new_repo, &block).data

      # puts "Query result: #{final_output}"
      final_output
    end

  end
end

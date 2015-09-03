require 'cuke_modeler'
require 'cql/dsl'

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_data data
      # puts "@whats: #{@what}"
      # puts "from data: #{data.collect { |datum| datum.class.to_s =~ /CukeModeler/ ? datum.class : datum }}"

      # puts "name transforms (#{@name_transforms.class}): #{@name_transforms}"
      # puts "value transforms (#{@value_transforms.class}): #{@value_transforms}"

      return data if @what.empty?

      Array.new.tap do |result_array|
        data.each do |element|
          result_array << Hash.new.tap do |result|
            @what.each_with_index do |attribute, index|
              # puts "attribute (#{attribute.class}): #{attribute}"
              # puts "index (#{index.class}): #{index}"

              value = element.send(attribute)

              if @name_transforms
                case
                  when @name_transforms.is_a?(Array)
                    key = @name_transforms[index]
                  when @name_transforms.is_a?(Hash)
                    if @name_transforms[attribute]
                      key = @name_transforms[attribute].first
                      @name_transforms[attribute].rotate!
                    end
                  else
                    # todo - add error message
                end
              end

              if @value_transforms

                case
                  when @value_transforms.is_a?(Array)
                    value = @value_transforms[index].call(value)
                  when @value_transforms.is_a?(Hash)
                    if @value_transforms[attribute]
                      value = @value_transforms[attribute].first.call(value)
                      @value_transforms[attribute].rotate!
                    end
                  else
                    # todo - add error message
                end

              end

              key ||= attribute

              # puts "key: #{key}"
              # puts "value: #{value}"

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

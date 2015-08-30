require 'cql/dsl'
require 'cql/feature_filters'
require 'cql/sso_filters'

require 'set'

module CQL
  QUERY_VALUES = %w(name uri line description type steps id tags examples)

  class MapReduce

    def self.name(data)
      data = data.dup
      data.map { |element| element.name }
    end

    def self.uri(data)
      data = data.dup
      data.map { |element| element.parent_element.path }
    end

    def self.description(data)
      data = data.dup
      data.map { |element| element.description.join("\n") }
    end

    def self.tags(data)
      data = data.dup
      data.map { |element| element.raw_element['tags'] }
    end

    def self.line(data)
      data = data.dup
      data.map { |element| element.source_line }
    end

    def self.examples(data)
      data = data.dup
      data.map { |element| element.examples.collect { |example| example.raw_element } }
    end

    def self.steps(data)
      data = data.dup
      data.map { |element| element.steps.collect { |step| step.raw_element } }
    end

    def self.type(data)
      data = data.dup
      data.map do |element|
        element_class = element.class.to_s[/::.*$/].gsub(':', '')

        case element_class
          when 'Outline'
            type = 'scenario_outline'
          when 'Scenario'
            type = 'scenario'
          else
            raise "Unknown class: #{element_class}"
        end

        type
      end
    end

    def self.id(data)
      data = data.dup
      data.map { |element| element.raw_element['id'] }
    end

    %w(all everything complete).each do |method_name|
      define_singleton_method(method_name) { |input| input }
    end

    def self.step_lines input
      input = [input] if input.class != Array
      steps(input).map do |scen|
        scen.map { |line| line['keyword'] + line['name'] }
      end
    end

    def self.gather_objects(current_object, target_classes, filters)
      # puts "current_object: #{ current_object.class.to_s =~ /CukeModeler/ ? current_object.class : current_object }"
      # puts "input: #{input.collect { |datum| datum.class.to_s =~ /CukeModeler/ ? datum.class : datum }}"
      # puts "target_classes: #{target_classes}"
      # puts "filters: #{filters}"

      gathered_objects = Array.new.tap { |gathered_objects| collect_all_in(target_classes, current_object, gathered_objects) }

      if filters
        # puts "Filters (#{filters.class}): #{filters}"
        filters.each do |filter|
          if filter.is_a?(Proc)
            gathered_objects.select!(&filter)
          else
            gathered_objects = filter.execute(gathered_objects)
          end
        end
      end

      gathered_objects
    end


    class << self


      private


      # Recursively gathers all objects of the given class found in the passed object (including itself).
      def collect_all_in(targeted_class, current_object, accumulated_objects)
        accumulated_objects << current_object if current_object.is_a?(targeted_class)

        if current_object.respond_to?(:contains)
          current_object.contains.each do |child_object|
            collect_all_in(targeted_class, child_object, accumulated_objects)
          end
        end
      end

    end

  end

end

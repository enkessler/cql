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

    def self.feature_children input, args
      results = []

      input.each do |feature|
        feature.contains.each do |element|

          case args['what']
            when 'scenario'
              results.push element if element.class.to_s[/::.*$/].gsub(':', '') == 'Scenario'
            when 'scenario_outline'
              results.push element if element.class.to_s[/::.*$/].gsub(':', '') == 'Outline'
            else
              raise "Unknown type: #{args['what']}"
          end

        end
      end

      results
    end

  end

end

require File.dirname(__FILE__) + "/map_reduce"
module CQL
  module Dsl
    %w(names features scenario_outlines uri scenarios line all description).each do |method_name|
      define_method(method_name) { method_name }
    end

    alias :* :all

    def select *what
      @what = what.first if what.size == 1
      @what = what if what.size > 1
    end

    def from where
      @from = where
      @data
    end

    def tags *tags
      {'tags'=>tags}
    end

    def with filter
      if filter.has_key? 'tags'
        @data = CQL::MapReduce.filter_features(@data, 'tags'=>filter['tags'])
      end
      @data
    end

    class Query
      include Dsl
      attr_reader :data, :what

      def initialize features, &block
        @data = features
        @data = self.instance_eval(&block)

        if @from == "scenario_outlines"
          @data= CQL::MapReduce.filter_sso(@data, 'what'=>'scenario_outline')
        elsif @from == "scenarios"
          @data = CQL::MapReduce.filter_sso(@data, 'what'=>'scenario')
        end

        if @what.class != Array
          if @what=='names'
            @data = CQL::MapReduce.name(@data)
          elsif @what=='description'
            @data = CQL::MapReduce.description(@data)
          elsif @what=='uri'
            @data = CQL::MapReduce.uri(@data)
          elsif @what=='line'
            @data = CQL::MapReduce.line(@data)
          end
          return @data
        end

        if @what.class == Array
          result = {}
          @what.each do |w|
            if w=='names'
              result['name'] = CQL::MapReduce.name(@data).first
            elsif w=='description'
              result['description'] = CQL::MapReduce.description(@data).first
            elsif w=='uri'
              result['uri'] = CQL::MapReduce.uri(@data).first
            elsif w=='line'
              result['line'] = CQL::MapReduce.line(@data).first
            end
          end

          @data = result
        end

      end
    end
  end
end
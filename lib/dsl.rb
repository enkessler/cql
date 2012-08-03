require File.dirname(__FILE__) + "/map_reduce"
module CQL
  module Dsl
    %w(name features scenario_outlines uri scenarios line all description type).each do |method_name|
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
          if @what=='name'
            @data = CQL::MapReduce.name(@data)
          elsif @what=='description'
            @data = CQL::MapReduce.description(@data)
          elsif @what=='uri'
            @data = CQL::MapReduce.uri(@data)
          elsif @what=='line'
            @data = CQL::MapReduce.line(@data)
          elsif @what=='type'
            @data = CQL::MapReduce.type(@data)
          end
          return @data
        end

        if @what.class == Array
          result = Array.new(@data.size)
          result = result.map { |e| {} }

          @what.each do |w|
            if w=='name'
              CQL::MapReduce.name(@data).each_with_index do |e, i|
                result[i]['name'] = e
              end
            elsif w=='description'
              CQL::MapReduce.description(@data).each_with_index do |e, i|
                result[i]['description'] = e
              end
            elsif w=='uri'
              CQL::MapReduce.uri(@data).each_with_index do |e, i|
                result[i]['uri'] = e
              end
            elsif w=='type'
              CQL::MapReduce.type(@data).each_with_index do |e, i|
                result[i]['type'] = e
              end
            elsif w=='line'
              CQL::MapReduce.line(@data).each_with_index do |e, i|
                result[i]['line'] = e
              end
            end
          end

          @data = result.size == 1 ? result.first : result
        end

      end
    end
  end
end
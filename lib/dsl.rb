module CQL
  module Dsl
    %w(names features scenario_outlines uri scenarios line all description).each do |method_name|
      define_method(method_name) { method_name }
    end

    alias :* :all

    def select what
      @what = what
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

        if @what=='names'
          @data = CQL::MapReduce.name(@data)
        elsif @what=='description'
          @data = CQL::MapReduce.description(@data)
        elsif @what=='uri'
          @data = CQL::MapReduce.uri(@data)
        elsif @what=='line'
          @data = CQL::MapReduce.line(@data)
        end

        @data
      end
    end
  end
end
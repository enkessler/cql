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
        key = @what + "-" + @from
        if key=="uri-features"
          @data = CQL::MapReduce.uri(@data)
        elsif key== "names-features"
          @data = CQL::MapReduce.name(@data)
        elsif key== "description-features"
          @data = CQL::MapReduce.description(@data)
        elsif @from== "scenario_outlines"
          @data= CQL::MapReduce.filter_sso(@data, 'what'=>'scenario_outline')
          #@data = CQL::MapReduce.name(@data)
        elsif key== "names-scenarios"
          @data = CQL::MapReduce.filter_sso(@data, 'what'=>'scenario')
          @data = CQL::MapReduce.name(@data)
        elsif key== "line-scenarios"
          @data = CQL::MapReduce.filter_sso(@data, 'what'=>'scenario')
          @data = CQL::MapReduce.line(@data)
        end

        if @from== "scenario_outlines"
          if @what=='names'
            @data = CQL::MapReduce.name(@data)
          elsif @what=='line'
            @data = CQL::MapReduce.line(@data)
          end
        end

        @data
      end
    end

  end

end
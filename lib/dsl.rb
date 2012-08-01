module GQL
  module Dsl

    def names
      'names'
    end

    def features
      'features'
    end

    def scenario_outlines
      'scenario_outlines'
    end

    def file_names
      'uri'
    end

    def scenarios
      'scenarios'
    end

    def select what
      @what = what
    end

    def from where
      @from = where
      @data
    end

    def tag tag
      {'tags'=>tag}
    end

    def tags *tags
      {'tags'=>tags}
    end

    def with filter
      if filter.has_key? 'tags'
        @data = GQL::MapReduce.find_feature(@data, 'tags'=>filter['tags'])
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
          @data = GQL::MapReduce.uri(@data)
        elsif key== "names-features"
          @data = GQL::MapReduce.overview(@data)
        elsif key== "names-scenario_outlines"
          @data= GQL::MapReduce.find(@data, 'what'=>'scenario_outline')
        elsif key== "names-scenarios"
          @data = GQL::MapReduce.find(@data, 'what'=>'scenario')
        end
        @data
      end
    end

  end

end
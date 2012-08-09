require File.dirname(__FILE__) + "/map_reduce"
module CQL
  DSL_KEYWORDS = %w(features scenario_outlines scenarios all step_lines examples)
  module Dsl
    (CQL::QUERY_VALUES + CQL::DSL_KEYWORDS).each do |method_name|
      define_method(method_name) { |*args|
        return method_name if args.size == 0
        {method_name=>args}
      }
    end

    %w(sc_gt sc_gte sc_lt sc_lte soc_gt soc_gte soc_lt soc_lte ssoc_gt ssoc_gte ssoc_lt ssoc_lte tc_lt tc_lte).each do |meth|
      define_method(meth) { |num| {meth=>num} }
    end

    alias :everything :all
    alias :complete :all

    def select *what
      @what = what
    end

    def from where
      @from = where
      @data
    end

    def tags *tags
      return "tags" if tags.size == 0
      {'tags'=>tags}
    end

    def with filter
      if filter.has_key? 'name'
        @data = CQL::MapReduce.filter_features(@data, 'feature'=>filter['name'])
      else
        filter.each { |k, v| @data = CQL::MapReduce.filter_features(@data, k=>v) }
      end
      @data
    end

    class Query
      include Dsl
      attr_reader :data, :what

      def initialize features, &block
        @data = features
        @data = self.instance_eval(&block)

        @data= CQL::MapReduce.filter_sso(@data, 'what'=>@from[0, @from.size-1]) if @from != "features"
        result = Array.new(@data.size)
        result = result.map {|e|{}}
        @what.each do |w|
          CQL::MapReduce.send(w, @data).each_with_index { |e, i| result[i][w]=e }
        end
        @data = result.size == 1 ? result.first : result
      end
    end
  end
end
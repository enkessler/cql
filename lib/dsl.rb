require File.dirname(__FILE__) + "/map_reduce"
module CQL
  DSL_KEYWORDS = %w(features scenario_outlines scenarios all step_lines examples name)
  module Dsl
    (CQL::QUERY_VALUES + CQL::DSL_KEYWORDS).each do |method_name|
      define_method(method_name) { |*args|
        return method_name if args.size == 0
        {method_name=>args}
      }
    end

    alias :everything :all
    alias :complete :all

    class Comparison
      attr_accessor :op, :amount

      def initialize op, amount
        @op = op
        @amount = amount
      end


      def operator
        {"lt"=>'<', 'lte'=>'<=', 'gt'=>'>', 'gte'=>'>='}[@op]
      end

    end

    class TagFilter
      attr_reader :tags

      def initialize tags
        @tags = tags
      end
    end

    class LineFilter
      attr_reader :line

      def initialize line
        @line = line
      end
    end

    def ssoc comparison
      {"ssoc_#{comparison.op}"=>comparison.amount}
    end

    def sc comparison
      {"sc_#{comparison.op}"=>comparison.amount}
    end

    def tc comparison
      {"tc_#{comparison.op}"=>comparison.amount}
    end

    def lc comparison
      {"lc_#{comparison.op}"=>comparison.amount}
    end

    def soc comparison
      {"soc_#{comparison.op}"=>comparison.amount}
    end

    def gt amount
      Comparison.new 'gt', amount
    end

    def gte amount
      Comparison.new 'gte', amount
    end

    def lt amount
      Comparison.new 'lt', amount
    end

    def lte amount
      Comparison.new 'lte', amount
    end

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
        filter_obj = CQL::NameFilter.new filter['name'][0]
        @data = CQL::MapReduce.filter_features(@data, filter_obj)
      elsif @from == 'features'
        filter.each do |k, v|
          if k =~ /ssoc/ || k =~ /sc/ || k =~ /soc/
            what, op = k.split /_/
            comp = Comparison.new(op, v)
            filter_obj = Filter.new what, comp
            @data = CQL::MapReduce.filter_features(@data, filter_obj)
          elsif k =~ /tc/
            what, op = k.split /_/
            comp = Comparison.new op, v
            filter_obj = FeatureTagCountFilter.new what, comp
            @data = CQL::MapReduce.filter_features(@data, filter_obj)
          elsif k =~ /tags/
            @data = CQL::MapReduce.filter_features(@data, TagFilter.new(v))
          end

        end


      elsif @from == 'scenarios'
        filter.each { |k, v|
          if k =~ /tc/ || k =~ /lc/
            what, op = k.split /_/
            comp = Comparison.new op, v
            filter_obj = Filter.new what, comp
            @data = CQL::MapReduce.filter_sso2(@data, filter_obj)
          elsif k == 'line'
            lf = LineFilter.new v.first
            @data = CQL::MapReduce.filter_sso2(@data, lf)
          else
            obj = TagFilter.new v
            @data = CQL::MapReduce.filter_sso2(@data, obj)
          end
        }
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
        result = result.map { |e| {} }
        @what.each do |w|
          CQL::MapReduce.send(w, @data).each_with_index { |e, i| result[i][w]=e }
        end
        @data = result.size == 1 ? result.first : result
      end
    end
  end
end
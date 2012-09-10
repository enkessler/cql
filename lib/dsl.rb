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

    def name *args
      return 'name' if args.size == 0
      CQL::NameFilter.new args[0]
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

    def ssoc comparison
      Filter.new('ssoc', comparison)
    end

    def sc comparison
      Filter.new('sc', comparison)
    end

    def tc comparison
      if @from == 'features'
        return FeatureTagCountFilter.new('tc', comparison)
      else
        return SsoTagCountFilter.new 'tc', comparison
      end
    end

    def lc comparison
      CQL::SsoLineCountFilter.new('lc', comparison)
    end

    def soc comparison
      Filter.new('soc', comparison)
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
      if @from == 'features'
        return FeatureTagFilter.new tags
      else
        return CQL::SsoTagFilter.new tags
      end
    end

    def with_sso_filter(filter)
      filter_obj = nil
      if filter.class == Hash
        filter.each { |k, v|
        if k == 'line'
            filter_obj = CQL::LineFilter.new v.first
          end
        }
      else
        filter_obj = filter
      end
      @data = filter_obj.execute(@data)
    end

    def with filter
      if @from == 'features'
        @data = filter.execute(@data)
      elsif @from == 'scenarios'
        with_sso_filter(filter)
      end
      @data
    end

  end
end
require File.dirname(__FILE__) + "/map_reduce"
module CQL
  module Dsl
    #Select clause
    def select *what
      @what = what
    end

    (CQL::QUERY_VALUES + %w(all step_lines examples)).each do |method_name|
      define_method(method_name) { |*args|
        return method_name if args.size == 0
        {method_name=>args}
      }
    end

    alias :everything :all
    alias :complete :all

    def name *args
      return 'name' if args.size == 0
      CQL::NameFilter.new args[0]
    end

    def line *args
      return 'line' if args.size == 0
      CQL::LineFilter.new args.first
    end

    #from clause
    def from where
      @from = where
      @data
    end

    %w(features scenario_outlines scenarios).each do |method_name|
      define_method(method_name) { |*args|
        return method_name if args.size == 0
        {method_name=>args}
      }
    end

    #with clause
    def with filter
      @data = filter.execute(@data)
    end

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
        FeatureTagCountFilter.new('tc', comparison)
      else
        SsoTagCountFilter.new 'tc', comparison
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

    def tags *tags
      return "tags" if tags.size == 0
      if @from == 'features'
        FeatureTagFilter.new tags
      else
        CQL::SsoTagFilter.new tags
      end
    end

  end
end
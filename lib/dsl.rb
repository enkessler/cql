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

    def ssoc comparison
      Filter.new('ssoc', comparison)
    end

    def sc comparison
      Filter.new('sc', comparison)
    end

    def tc comparison
      {"tc_#{comparison.op}"=>comparison.amount}
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
      {'tags'=>tags}
    end

    def with_feature_filter(filter)
      filter_obj = nil
      if filter.class == Hash
        filter.each do |k, v|
          what, op = k.split /_/
          comp = Comparison.new(op, v)
          if k == 'name'
            filter_obj = CQL::NameFilter.new v[0]
          elsif k =~ /tc/
            filter_obj = FeatureTagCountFilter.new(what, comp)
          elsif k =~ /tags/
            filter_obj = CQL::FeatureTagFilter.new(v)
          end
        end
      else
        filter_obj = filter
      end
      @data = filter_obj.execute(@data)

    end

    def with_sso_filter(filter)
      filter_obj = nil
      if filter.class == Hash
        filter.each { |k, v|
          if k =~ /tc/
            what, op = k.split /_/
            comp = Comparison.new(op, v)
            filter_obj = SsoTagCountFilter.new(what, comp)
          elsif k == 'line'
            filter_obj = CQL::LineFilter.new v.first
          else
            filter_obj = CQL::SsoTagFilter.new v
          end
        }
      else
        filter_obj = filter
      end
      @data = filter_obj.execute(@data)
    end

    def with filter
      if @from == 'features'
        with_feature_filter(filter)
      elsif @from == 'scenarios'
        with_sso_filter(filter)
      end
      @data
    end

  end
end
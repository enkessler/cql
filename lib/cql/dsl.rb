require 'cql/map_reduce'

module CQL
  module Dsl

    def method_missing(method_name)
      method_name.to_s
    end

    def transform(*attribute_transforms)
      # todo - accept either array or a hash
      # puts "transform args: #{attribute_transforms}"
      if attribute_transforms.first.is_a?(Hash)
        additional_transforms = attribute_transforms.first

        @value_transforms ||= {}
        additional_transforms.each do |key, value|
          if @value_transforms.has_key?(key)
            @value_transforms[key] << value
          else
            @value_transforms[key] = [value]
          end
        end
      else

        @value_transforms = attribute_transforms
      end
    end

    def as(*name_transforms)
      # todo - accept either array or a hash
      # puts "as args: #{name_transforms}"
      if name_transforms.first.is_a?(Hash)
        additional_transforms = name_transforms.first

        @name_transforms ||= {}
        additional_transforms.each do |key, value|
          if @name_transforms.has_key?(key)
            @name_transforms[key] << value
          else
            @name_transforms[key] = [value]
          end
        end
      else

        @name_transforms = name_transforms
      end
    end

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
      # puts "'from' (#{where.class}): #{where}"

      if where.is_a?(String)
        # Translate shorthand Strings to final class

        where = where.to_s
        where = where.split('_')
        where = where.map(&:capitalize)
        where = where.join
        # puts "converted where: #{where}"

        # Check for pluralization of class match (i.e. remove the final 's')
        if CukeModeler.const_defined?(where.chop)
          @from = CukeModeler.const_get(where.chop)
        end

        # Check for exact class match
        if CukeModeler.const_defined?(where)
          @from = CukeModeler.const_get(where)
        end
      end

      # Assume that either the string has been converted to a class or that the starting argument was already a class
      @from ||= where

      # puts "@from: #{@from}"
    end

    %w(features scenario_outlines scenarios).each do |method_name|
      define_method(method_name) { |*args|
        return method_name if args.size == 0
        {method_name=>args}
      }
    end

    #with clause
    def with(&block)
      # puts "block received: #{block}"
      @filter_blocks ||= []

      @filter_blocks << block

      # puts "final filter: #{@filter_block}"
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

    def ssoc comparison
      Filter.new('ssoc', comparison)
    end

    def sc comparison
      Filter.new('sc', comparison)
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
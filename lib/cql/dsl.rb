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
      @what ||= []
      @what.concat(what)
    end

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

      @from ||= []

      if where.is_a?(String)
        # Translate shorthand Strings to final class

        where = where.to_s
        where = where.split('_')
        where = where.map(&:capitalize)
        where = where.join
        # puts "converted where: #{where}"

        # Check for exact class match first because it should take precedence
        if CukeModeler.const_defined?(where)
          @from << CukeModeler.const_get(where)
          return
        end

        # Check for pluralization of class match (i.e. remove the final 's')
        if CukeModeler.const_defined?(where.chop)
          @from << CukeModeler.const_get(where.chop)
          return
        end
      end

      # Assume starting argument was already a class
      @from << where

      # puts "@from: #{@from}"
    end


    #with clause
    def with(matcher = nil, &block)
      # puts "matcher received: #{matcher}"
      # puts "block received: #{block}"
      @filters ||= []

      @filters << block if block
      @filters << matcher if matcher

      # puts "final filters: #{@filters}"
    end

    class Comparison
      attr_accessor :operator, :amount

      def initialize operator, amount
        @operator = operator
        @amount = amount
      end

    end

    def tc comparison
      if @from == CukeModeler::Feature
        FeatureTagCountFilter.new('tc', comparison)
      else
        SsoTagCountFilter.new 'tc', comparison
      end
    end

    def lc comparison
      CQL::SsoLineCountFilter.new('lc', comparison)
    end

    def ssoc comparison
      TestCountFilter.new([CukeModeler::Scenario, CukeModeler::Outline], comparison)
    end

    def sc comparison
      TestCountFilter.new([CukeModeler::Scenario], comparison)
    end

    def soc comparison
      TestCountFilter.new([CukeModeler::Outline], comparison)
    end

    def gt amount
      Comparison.new '>', amount
    end

    def gte amount
      Comparison.new '>=', amount
    end

    def lt amount
      Comparison.new '<', amount
    end

    def lte amount
      Comparison.new '<=', amount
    end

    def tags *tags
      return "tags" if tags.size == 0

      TagFilter.new tags
    end

  end
end
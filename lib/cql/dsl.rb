module CQL

  # The Domain Specific Language used for performing queries.

  module Dsl


    # Any undefined method is assumed to mean its String equivalent, thus allowing a more convenient query syntax.
    def method_missing(method_name)
      method_name.to_s
    end

    # Adds a *transform* clause to the query. See the corresponding Cucumber documentation for details.
    def transform(*attribute_transforms, &block)
      # todo - Still feels like some as/transform code duplication but I think that it would get too meta if I
      # reduced it any further. Perhaps change how the transforms are handled so that there doesn't have to be
      # an array/hash difference in the first place?
      prep_variable('value_transforms', attribute_transforms) unless @value_transforms

      # todo - what if they pass in a hash transform and a block?
      attribute_transforms << block if block
      add_transforms(attribute_transforms, @value_transforms)
    end

    # Adds an *as* clause to the query. See the corresponding Cucumber documentation for details.
    def as(*name_transforms)
      prep_variable('name_transforms', name_transforms) unless @name_transforms

      add_transforms(name_transforms, @name_transforms)
    end

    # Adds a *select* clause to the query. See the corresponding Cucumber documentation for details.
    def select *what
      what = [:self] if what.empty?

      @what ||= []
      @what.concat(what)
    end

    # Adds a *name* filter to the query. See the corresponding Cucumber documentation for details.
    def name *args
      return 'name' if args.size == 0
      CQL::NameFilter.new args[0]
    end

    # Adds a *line* filter to the query. See the corresponding Cucumber documentation for details.
    def line *args
      return 'line' if args.size == 0
      CQL::LineFilter.new args.first
    end

    # Adds a *from* clause to the query. See the corresponding Cucumber documentation for details.
    def from(*targets)
      @from ||= []

      targets.map! { |target| target.is_a?(String) ? determine_class(target) : target }

      @from.concat(targets)
    end

    # Adds a *with* clause to the query. See the corresponding Cucumber documentation for details.
    def with(*conditions, &block)
      @filters ||= []

      @filters << {:negate => false, :filter => block} if block
      conditions.each do |condition|
        @filters << {:negate => false, :filter => condition}
      end
    end

    # Adds a *without* clause to the query. See the corresponding Cucumber documentation for details.
    def without(*conditions, &block)
      @filters ||= []

      @filters << {:negate => true, :filter => block} if block
      conditions.each do |condition|
        @filters << {:negate => true, :filter => condition}
      end
    end

    # Not a part of the public API. Subject to change at any time.
    class Comparison
      attr_accessor :operator, :amount

      def initialize operator, amount
        @operator = operator
        @amount = amount
      end

    end

    # Adds a *tc* filter to the query. See the corresponding Cucumber documentation for details.
    def tc comparison
      TagCountFilter.new 'tc', comparison
    end

    # Adds a *lc* filter to the query. See the corresponding Cucumber documentation for details.
    def lc comparison
      CQL::SsoLineCountFilter.new('lc', comparison)
    end

    # Adds an *ssoc* filter to the query. See the corresponding Cucumber documentation for details.
    def ssoc comparison
      TestCountFilter.new([CukeModeler::Scenario, CukeModeler::Outline], comparison)
    end

    # Adds an *sc* filter to the query. See the corresponding Cucumber documentation for details.
    def sc comparison
      TestCountFilter.new([CukeModeler::Scenario], comparison)
    end

    # Adds an *soc* filter to the query. See the corresponding Cucumber documentation for details.
    def soc comparison
      TestCountFilter.new([CukeModeler::Outline], comparison)
    end

    # Adds a *gt* filter operator to the query. See the corresponding Cucumber documentation for details.
    def gt amount
      Comparison.new '>', amount
    end

    # Adds a *gte* filter operator to the query. See the corresponding Cucumber documentation for details.
    def gte amount
      Comparison.new '>=', amount
    end

    # Adds an *lt* filter operator to the query. See the corresponding Cucumber documentation for details.
    def lt amount
      Comparison.new '<', amount
    end

    # Adds an *lte* filter operator to the query. See the corresponding Cucumber documentation for details.
    def lte amount
      Comparison.new '<=', amount
    end

    # Adds an *eq* filter operator to the query. See the corresponding Cucumber documentation for details.
    def eq amount
      Comparison.new '==', amount
    end

    # Adds a *tags* filter to the query. See the corresponding Cucumber documentation for details.
    def tags *tags
      return "tags" if tags.size == 0

      TagFilter.new tags
    end


    private


    def translate_shorthand(where)
      where.split('_').map(&:capitalize).join
    end

    def prep_variable(var_name, transforms)
      starting_value = transforms.first.is_a?(Hash) ? {} : []
      instance_variable_set("@#{var_name}".to_sym, starting_value)
    end

    def add_transforms(new_transforms, transform_set)
      # todo - accept either array or a hash
      if new_transforms.first.is_a?(Hash)
        additional_transforms = new_transforms.first

        additional_transforms.each do |key, value|
          if transform_set.has_key?(key)
            transform_set[key] << value
          else
            transform_set[key] = [value]
          end
        end
      else

        transform_set.concat(new_transforms)
      end
    end

    def determine_class(where)
      # Translate shorthand Strings to final class
      where = translate_shorthand(where)

      # Check for exact class match first because it should take precedence
      return CukeModeler.const_get(where) if CukeModeler.const_defined?(where)

      # Check for pluralization of class match (i.e. remove the final 's')
      return CukeModeler.const_get(where.chop) if CukeModeler.const_defined?(where.chop)

      # Then the class must not be a CukeModeler class
      raise(ArgumentError, "Class 'CukeModeler::#{where}' does not exist")
    end

  end
end

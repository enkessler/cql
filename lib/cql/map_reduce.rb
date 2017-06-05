require 'cql/dsl'
require 'cql/feature_filters'
require 'cql/sso_filters'
require 'cql/dsl'


module CQL

  # Not a part of the public API. Subject to change at any time.
  class MapReduce

    extend Dsl

    def self.gather_objects(current_object, target_classes, filters)
      gathered_objects = Array.new.tap { |gathered_objects| collect_all_in(target_classes, current_object, gathered_objects) }

      if filters
        filters.each do |filter|
          negate = filter[:negate]
          filter = filter[:filter]

          # Non-targeted filter, will apply to all objects
          if filter.is_a?(Proc)
            gathered_objects = filter_with_proc(gathered_objects, filter, negate)

            # Targeted filter, will only apply to certain objects
          elsif filter.is_a?(Hash)
            filter.keys.each do |filtered_class|
              clazz = determine_class(filtered_class)

              gathered_objects = gathered_objects.select do |object|

                # A class that is targeted by the filter, so proceed with determination
                if object.is_a?(clazz)

                  # Block filter
                  if filter[filtered_class].is_a?(Proc)
                    filter[filtered_class].call(object) && !negate

                    # Must be a predefined filter otherwise
                  else
                    !filter_with_predefined([object], filter[filtered_class], negate).empty?
                  end

                  # Not a class that is targeted by the filter, so include it
                else
                  true
                end
              end
            end

            # Must be a predefined filter otherwise
          else
            gathered_objects = filter_with_predefined(gathered_objects, filter, negate)
          end
        end
      end

      gathered_objects
    end


    class << self


      private


      def filter_with_proc(objects, filter, negate)
        if negate
          objects.reject(&filter)
        else
          objects.select(&filter)
        end
      end

      def filter_with_predefined(objects, filter, negate)
        filter.execute(objects, negate)
      end

      # Recursively gathers all objects of the given class(es) found in the passed object (including itself).
      def collect_all_in(targeted_classes, current_object, accumulated_objects)
        accumulated_objects << current_object if targeted_classes.any? { |targeted_class| (targeted_class == :all) || current_object.is_a?(targeted_class) }

        method_for_children = Gem.loaded_specs['cuke_modeler'].version.version[/^0/] ? :contains : :children

        if current_object.respond_to?(method_for_children)
          current_object.send(method_for_children).each do |child_object|
            collect_all_in(targeted_classes, child_object, accumulated_objects)
          end
        end
      end

    end

  end

end

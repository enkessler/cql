require 'cql/dsl'
require 'cql/feature_filters'
require 'cql/sso_filters'
require 'cql/dsl'


module CQL

  class MapReduce

    extend Dsl

    def self.gather_objects(current_object, target_classes, filters)
      gathered_objects = Array.new.tap { |gathered_objects| collect_all_in(target_classes, current_object, gathered_objects) }

      if filters
        filters.each do |filter|
          if filter.is_a?(Proc)
            gathered_objects = filter_with_proc(gathered_objects, filter)
          elsif filter.is_a?(Hash)
            filter.keys.each do |filtered_class|
              clazz = determine_class(filtered_class)

              gathered_objects = gathered_objects.select do |object|
                if object.is_a?(clazz)
                  if filter[filtered_class].is_a?(Proc)
                    filter[filtered_class].call(object)
                  else
                    # Must be a predefined filter otherwise
                    !filter_with_predefined([object], filter[filtered_class]).empty?
                  end
                else
                  true
                end
              end
            end
          else
            # Must be a predefined filter otherwise
            gathered_objects = filter_with_predefined(gathered_objects, filter)
          end
        end
      end

      gathered_objects
    end


    class << self


      private


      def filter_with_proc(objects, filter)
        objects.select(&filter)
      end

      def filter_with_predefined(objects, filter)
        filter.execute(objects)
      end

      # Recursively gathers all objects of the given class(es) found in the passed object (including itself).
      def collect_all_in(targeted_classes, current_object, accumulated_objects)
        accumulated_objects << current_object if targeted_classes.any? { |targeted_class| current_object.is_a?(targeted_class) }

        if current_object.respond_to?(:contains)
          current_object.contains.each do |child_object|
            collect_all_in(targeted_classes, child_object, accumulated_objects)
          end
        end
      end

    end

  end

end

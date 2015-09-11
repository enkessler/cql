require 'cql/dsl'
require 'cql/feature_filters'
require 'cql/sso_filters'


module CQL

  class MapReduce

    def self.gather_objects(current_object, target_classes, filters)
      gathered_objects = Array.new.tap { |gathered_objects| collect_all_in(target_classes, current_object, gathered_objects) }

      if filters
        filters.each do |filter|
          if filter.is_a?(Proc)
            gathered_objects.select!(&filter)
          else
            gathered_objects = filter.execute(gathered_objects)
          end
        end
      end

      gathered_objects
    end


    class << self


      private


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

require 'cuke_modeler'
require File.dirname(__FILE__) + "/dsl"

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_to_ary_of_hsh data
      result = Array.new(data.size).map { |e| {} }

      @what.each do |w|
        CQL::MapReduce.send(w, data).each_with_index do |e, i|
          if e.class.to_s =~ /CukeModeler/
            result[i][w]=e.raw_element
          else
            result[i][w]=e
          end
        end
      end

      result
    end

    def initialize features, &block
      @data = features
      @data = self.instance_eval(&block)

      #getting the children of features
      @data= CQL::MapReduce.feature_children(@data, 'what'=>@from[0, @from.size-1]) if @from != "features"

      @data= format_to_ary_of_hsh(@data)
    end
  end


  class Repository
    attr_reader :parsed_feature_files

    def initialize features_home_dir
      @parsed_feature_files = collect_feature_models(CukeModeler::Directory.new(features_home_dir))
    end

    def query &block
      new_repo = Marshal::load(Marshal.dump(parsed_feature_files))

      Query.new(new_repo, &block).data
    end


    private


    def collect_feature_models(directory_model)
      Array.new.tap { |accumulated_features| collect_all_in(:features, directory_model, accumulated_features) }
    end

    # Recursively gathers all things of the given type found in the passed container.
    def collect_all_in(type_of_thing, container, accumulated_things)
      accumulated_things.concat container.send(type_of_thing) if container.respond_to?(type_of_thing)

      if container.respond_to?(:contains)
        container.contains.each do |child_container|
          collect_all_in(type_of_thing, child_container, accumulated_things)
        end
      end
    end

  end
end

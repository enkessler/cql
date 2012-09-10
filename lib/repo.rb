require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require File.dirname(__FILE__) + "/dsl"

module CQL

  class Query
    include Dsl
    attr_reader :data, :what

    def format_to_ary_of_hsh data
      result = Array.new(data.size)
      result = result.map { |e| {} }
      @what.each do |w|
        CQL::MapReduce.send(w, data).each_with_index { |e, i| result[i][w]=e }
      end
      result.size == 1 ? result.first : result
    end

    def initialize features, &block
      @data = features
      @data = self.instance_eval(&block)

      #getting the clidren of features
      @data= CQL::MapReduce.feature_children(@data, 'what'=>@from[0, @from.size-1]) if @from != "features"

      @data= format_to_ary_of_hsh(@data)
    end
  end


  class Repository
    attr_reader :parsed_feature_files

    def initialize features_home_dir
      @parsed_feature_files = load_features(list_features(features_home_dir))
    end

    def query &block
      Query.new(parsed_feature_files.clone, &block).data
    end

    private
    def list_features base_dir
      Dir.glob(base_dir + "/**/*.feature")
    end

    def load_features sources
      io = StringIO.new
      formatter = Gherkin::Formatter::JSONFormatter.new(io)
      parser = Gherkin::Parser::Parser.new(formatter)
      sources.each { |s| parser.parse(IO.read(s), s, 0) }
      formatter.done
      JSON.parse(io.string)
    end

  end
end
require 'gherkin/parser/parser'
require 'gherkin/formatter/json_formatter'
require 'stringio'
require 'json'
require 'set'

require File.dirname(__FILE__) + "/map_reduce"
require File.dirname(__FILE__) + "/dsl"

module CQL
  class Repository
    include Dsl
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
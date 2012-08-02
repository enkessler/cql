require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe "tag searcher" do
    it "should be able to search for tags" do
      tags_given = [{"name"=>"@one", "line"=>3}, {"name"=>"@four", "line"=>3}, {"name"=>"@six", "line"=>3}, {"name"=>"@seven", "line"=>3}]
      CQL::MapReduce.has_tags(tags_given, ["@one", "@four"]).should eql true

      tags_given = [{"name"=>"@two", "line"=>3}, {"name"=>"@four", "line"=>3}, {"name"=>"@six", "line"=>3}, {"name"=>"@seven", "line"=>3}]
      CQL::MapReduce.has_tags(tags_given, ["@one", "@four"]).should eql false

      tags_given = [{"name"=>"@two", "line"=>3}, {"name"=>"@four", "line"=>3}, {"name"=>"@six", "line"=>3}, {"name"=>"@seven", "line"=>3}]
      CQL::MapReduce.has_tags(tags_given, ["@four"]).should eql true

      tags_given = [{"name"=>"@two", "line"=>3}, {"name"=>"@four", "line"=>3}, {"name"=>"@six", "line"=>3}, {"name"=>"@seven", "line"=>3}]
      CQL::MapReduce.has_tags(tags_given, ["@four", "@two", "@six", "@seven"]).should eql true
    end
  end

end
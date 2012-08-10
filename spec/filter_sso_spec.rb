require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do
  describe 'tag count' do
    {
        0=>[],
        1=>[],
        2=>{"name"=> "1 tag"},
        3=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}],
        4=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}],
        5=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_lt' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tag_count"

        result = gs.query do
          select name
          from scenarios
          with tc_lt number
        end

        result.should == expected
      end
    end

    {
        0=>[],
        1=>{"name"=> "1 tag"},
        2=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}],
        3=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}],
        4=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        5=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_lte' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tag_count"

        result = gs.query do
          select name
          from scenarios
          with tc_lte number
        end

        result.should == expected
      end
    end

    {
        0=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        1=>[{"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        2=>[{"name"=> "3 tags"}, {"name"=> "4 tags"}],
        3=>{"name"=> "4 tags"},
        4=>[]


    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_gt' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tag_count"

        result = gs.query do
          select name
          from scenarios
          with tc_gt number
        end

        result.should == expected
      end
    end

    {
        0=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        1=>[{"name"=> "1 tag"}, {"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        2=>[{"name"=> "2 tags"}, {"name"=> "3 tags"}, {"name"=> "4 tags"}],
        3=>[{"name"=> "3 tags"}, {"name"=> "4 tags"}],
        4=>{"name"=> "4 tags"},
        5 =>[]


    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_gte' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tag_count"

        result = gs.query do
          select name
          from scenarios
          with tc_gte number
        end

        result.should == expected
      end
    end


  end
  # Tag count

  # Line count
  # Has tag
  # Name
  # Name match
  # Line match
  # line

  # Example count
end
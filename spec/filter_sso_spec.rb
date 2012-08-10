require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do
  describe 'tag count' do
    {
        0=>[],
        1=>[],
        2=>{"name"=> "1_tag"},
        3=>[{"name"=> "1_tag"}, {"name"=> "2_tags"}],
        4=>[{"name"=> "1_tag"}, {"name"=> "2_tags"}, {"name"=> "3_tags"}],
        5=>[{"name"=> "1_tag"}, {"name"=> "2_tags"}, {"name"=> "3_tags"}, {"name"=> "4_tags"}]

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
  end
  # Tag count
  # Has tag
  # Name
  # Name match
  # Line count
  # Line match
  # line

  # Example count
end
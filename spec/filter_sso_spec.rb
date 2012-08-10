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

  describe 'line count' do
    {
        0=>[],
        1=>[],
        2=>{"name"=> "1 line"},
        3=>[{"name"=> "1 line"}, {"name"=> "2 lines"}],
        4=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}],
        5=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'tc_lt' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/line_count"

        result = gs.query do
          select name
          from scenarios
          with lc_lt number
        end

        result.should == expected
      end
    end

    {
        0=>[],
        1=>{"name"=> "1 line"},
        2=>[{"name"=> "1 line"}, {"name"=> "2 lines"}],
        3=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}],
        4=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        5=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_lte' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/line_count"

        result = gs.query do
          select name
          from scenarios
          with lc_lte number
        end

        result.should == expected
      end
    end

    {
        0=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        1=>[{"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        2=>[{"name"=> "3 lines"}, {"name"=> "4 lines"}],
        3=>{"name"=> "4 lines"},
        4=>[]


    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_gt' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/line_count"

        result = gs.query do
          select name
          from scenarios
          with lc_gt number
        end

        result.should == expected
      end
    end

    {
        0=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        1=>[{"name"=> "1 line"}, {"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        2=>[{"name"=> "2 lines"}, {"name"=> "3 lines"}, {"name"=> "4 lines"}],
        3=>[{"name"=> "3 lines"}, {"name"=> "4 lines"}],
        4=>{"name"=> "4 lines"},
        5 =>[]


    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_gte' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/line_count"

        result = gs.query do
          select name
          from scenarios
          with lc_gte number
        end

        result.should == expected
      end
    end


  end

  describe 'exact line match' do
    it 'should filter based on an exact line' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/line_filter"

      result = gs.query do
        select name
        from scenarios
        with line 'green eggs and ham'
      end

      result.size.should == 1

    end
  end

  # Has tag
  # Name
  # Name match
  # Line match
  # line

  # Example count
end
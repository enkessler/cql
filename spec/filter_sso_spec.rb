require 'spec_helper'

describe "cql" do
  describe 'tag count' do
    {
        0 => [],
        1 => [],
        2 => [{"name" => "1 tag"}],
        3 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
        4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
        5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]
    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc lt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tag_count")

        result = gs.query do
          select name
          from scenarios
          with tc lt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [],
        1 => [{"name" => "1 tag"}],
        2 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
        3 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
        4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_lte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tag_count")

        result = gs.query do
          select name
          from scenarios
          with tc lte number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        1 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        2 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
        3 => [{"name" => "4 tags"}],
        4 => []
    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_gt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tag_count")

        result = gs.query do
          select name
          from scenarios
          with tc gt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        1 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        2 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
        3 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
        4 => [{"name" => "4 tags"}],
        5 => []
    }.each do |number, expected|
      it "should filter scenarios by the number of tags with the 'tc_gte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tag_count")

        result = gs.query do
          select name
          from scenarios
          with tc gte number
        end

        expect(result).to eq(expected)
      end
    end


  end

  describe 'line count' do
    {
        0 => [],
        1 => [],
        2 => [{"name" => "1 line"}],
        3 => [{"name" => "1 line"}, {"name" => "2 lines"}],
        4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
        5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_lt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

        result = gs.query do
          select name
          from scenarios
          with lc lt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [],
        1 => [{"name" => "1 line"}],
        2 => [{"name" => "1 line"}, {"name" => "2 lines"}],
        3 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
        4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]

    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_lte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

        result = gs.query do
          select name
          from scenarios
          with lc lte number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        1 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        2 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
        3 => [{"name" => "4 lines"}],
        4 => []


    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_gt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

        result = gs.query do
          select name
          from scenarios
          with lc gt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        1 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        2 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
        3 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
        4 => [{"name" => "4 lines"}],
        5 => []


    }.each do |number, expected|
      it "should filter scenarios by the number of lines with the 'lc_gte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

        result = gs.query do
          select name
          from scenarios
          with lc gte number
        end

        expect(result).to eq(expected)
      end
    end


  end

  describe 'exact line match' do
    it 'should filter based on an exact line' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = gs.query do
        select name
        from scenarios
        with line 'green eggs and ham'
      end

      expect(result.size).to eq(1)
    end

    it 'should filter all results when the exact line given does not match' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = gs.query do
        select name
        from scenarios
        with line 'no match'
      end

      expect(result.size).to eq(0)
    end

    it 'should filter no results when the exact line given is present in all scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = gs.query do
        select name
        from scenarios
        with line 'a cat in a hat'
      end

      expect(result.size).to eq(2)
    end
  end

  describe 'exact line match' do
    it 'should filter based on a regexp match' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = gs.query do
        select name
        from scenarios
        with line /green/
      end

      expect(result.size).to eq(1)
    end

    it 'should filter all if no regexp match' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = gs.query do
        select name
        from scenarios
        with line /will not be found/
      end

      expect(result.size).to eq(0)
    end

    it 'should filter none if all match regexp' do
      repo = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      result = repo.query do
        select name
        from scenarios
        with line /cat/
      end

      expect(result.size).to eq(2)
    end

  end

  describe 'tag search' do
    it 'should return scenarios with matching tags' do
      repo = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tags")

      result = repo.query do
        select name
        from scenarios
        with tags '@one'
      end

      expect(result).to eq([{'name' => 'Next'}, {'name' => 'Another'}])
    end
  end

  # Has tag
  # Name
  # Name match

  # Example count
end

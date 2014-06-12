require 'spec_helper'

describe "cql" do

  describe 'scenario outline and scenario count functions' do
    it 'should filter based on the number of scenarios for ssoc_gt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with ssoc gt 5
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"}])
    end

    it 'should filter based on the number of scenario outlines for ssoc_gte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with ssoc gte 5
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with ssoc gte 9
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"}])

      result = gs.query do
        select name
        from features
        with soc gte 1
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with soc gte 10
      end

      expect(result).to eq([])
    end

    it 'should filter based on the number of scenarios for ssoc_lt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with ssoc lt 10
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with ssoc lt 9
      end

      expect(result).to eq([{"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with ssoc lt 3
      end

      expect(result).to eq([])
    end

    it 'should filter based on the number of scenarios for ssoc_lte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with ssoc lte 10
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with ssoc lte 9
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with ssoc lte 5
      end

      expect(result).to eq([{"name" => "f3_2_scenarios_3_so"}])


      result = gs.query do
        select name
        from features
        with ssoc lte 4
      end

      expect(result).to eq([])
    end

  end


  describe 'scenario count functions' do
    it 'should filter based on the number of scenarios for sc_gt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with sc gt 2
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"}])
    end

    it 'should filter based on the number of scenarios for sc_gte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with sc gte 2
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with sc gte 4
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"}])

      result = gs.query do
        select name
        from features
        with sc gte 3
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"}])

      result = gs.query do
        select name
        from features
        with sc gte 7
      end

      expect(result).to eq([{"name" => "f2_7_scenarios_2_so"}])
    end

    it 'should filter based on the number of scenarios for sc_lt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with sc lt 7
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with sc lt 5
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with sc lt 4
      end

      expect(result).to eq([{"name" => "f3_2_scenarios_3_so"}])
    end

    it 'should filter based on the number of scenarios for sc_lte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      result = gs.query do
        select name
        from features
        with sc lte 7
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f2_7_scenarios_2_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with sc lte 5
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"},
                            {"name" => "f3_2_scenarios_3_so"}])

      result = gs.query do
        select name
        from features
        with sc lte 4
      end

      expect(result).to eq([{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}])
    end

    it 'should filter on the number of tags on a feature' do

    end
  end

  describe 'filter by tag count' do

    {
        0 => [],
        1 => [],
        2 => [{"name" => "f1_1_tag"}],
        3 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}],
        4 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        5 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}]

    }.each do |number, expected|
      it "should filter features by the number of tags with the 'tc_lt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

        result = gs.query do
          select name
          from features
          with tc lt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [],
        1 => [{"name" => "f1_1_tag"}],
        2 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}],
        3 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        4 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}]

    }.each do |number, expected|
      it "should filter features by the number of tags with the 'tc_lte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

        result = gs.query do
          select name
          from features
          with tc lte number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        1 => [{"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        2 => [{"name" => "f3_3_tags"}],
        3 => [],
        4 => []

    }.each do |number, expected|
      it "should filter features by the number of tags with the 'tc_gt' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

        result = gs.query do
          select name
          from features
          with tc gt number
        end

        expect(result).to eq(expected)
      end
    end

    {
        0 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        1 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        2 => [{"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
        3 => [{"name" => "f3_3_tags"}],
        4 => [],
        5 => []

    }.each do |number, expected|
      it "should filter features by the number of tags with the 'tc_gte' operator for count of #{number}" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

        result = gs.query do
          select name
          from features
          with tc gte number
        end

        expect(result).to eq(expected)
      end
    end

  end

  describe 'scenario outline count functions' do
    {
        2 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
        3 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}],
        4 => [{"name" => "f1_4_scenarios_5_so"}],
        7 => []

    }.each do |number, expected|
      it "soc_gte filter should filter scenarios for input '#{number}'" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

        result = gs.query do
          select name
          from features
          with soc gte number
        end

        expect(result).to eq(expected)
      end
    end

    {
        7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
        5 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
        4 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],

    }.each do |number, expected|
      it "soc_lt filter should filter scenarios for input '#{number}'" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")
        result = gs.query do
          select name
          from features
          with soc lt number
        end

        expect(result).to eq(expected)
      end
    end


    {
        7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
        5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
        4 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
    }.each do |num, expected|
      it "should filter based on the number of scenarios for soc_lte with input '#{num}'" do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

        result = gs.query do
          select name
          from features
          with soc lte num
        end

        expect(result).to eq(expected)
      end
    end
  end


  describe 'filter features by name' do
    it 'should filter by name' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name
        from features
        with name 'Test2 Feature'
      end

      expect(result).to eq([{"name" => "Test2 Feature"}])
    end

    it 'should filter by name regexp' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name
        from features
        with name /Test2 Feature/
      end

      expect(result).to eq([{"name" => "Test2 Feature"}])

      result = gs.query do
        select name
        from features
        with name /Feature/
      end

      expect(result.size).to eq(3)
    end
  end

  describe 'filter features by tag' do
    it 'should filter by a single tag' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name
        from features
        with tags '@one'
      end

      expect(result).to eq([{"name" => "Test Feature"}, {"name" => "Test3 Feature"}])

      result = gs.query do
        select name
        from features
        with tags '@two'
      end

      expect(result).to eq([{"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}])
    end

    it 'should filter by multiple filters' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name
        from features
        with tags '@two'
        with tags '@one'
      end

      expect(result).to eq([{"name" => "Test3 Feature"}])
    end

    it 'should filter by a multiple tags' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name
        from features
        with tags '@one', '@two'
      end

      expect(result).to eq([{"name" => "Test3 Feature"}])
    end
  end

end

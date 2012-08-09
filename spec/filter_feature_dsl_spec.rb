require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe 'scenario outline and scenario count functions' do
    it 'should filter based on the number of scenarios for ssoc_gt' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with ssoc_gt 5
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"}]
    end

    it 'should filter based on the number of scenario outlines for ssoc_gte' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with ssoc_gte 5
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with ssoc_gte 9
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"}]

      result = gs.query do
        select name
        from features
        with soc_gte 1
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with soc_gte 10
      end

      result.should == []
    end

    it 'should filter based on the number of scenarios for ssoc_lt' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with ssoc_lt 10
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with ssoc_lt 9
      end

      result.should == {"name"=> "f3_2_scenarios_3_so"}

      result = gs.query do
        select name
        from features
        with ssoc_lt 3
      end

      result.should == []
    end

    it 'should filter based on the number of scenarios for ssoc_lte' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with ssoc_lte 10
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=>"f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with ssoc_lte 9
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=>"f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with ssoc_lte 5
      end

      result.should == {"name"=> "f3_2_scenarios_3_so"}


      result = gs.query do
        select name
        from features
        with ssoc_lte 4
      end

      result.should == []
    end

  end


  describe 'scenario count functions' do
    it 'should filter based on the number of scenarios for sc_gt' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with sc_gt 2
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"}]
    end

    it 'should filter based on the number of scenarios for sc_gte' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with sc_gte 2
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with sc_gte 4
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"}]

      result = gs.query do
        select name
        from features
        with sc_gte 3
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f2_7_scenarios_2_so"}]

      result = gs.query do
        select name
        from features
        with sc_gte 7
      end

      result.should == {"name"=> "f2_7_scenarios_2_so"}
    end

    it 'should filter based on the number of scenarios for sc_lt' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with sc_lt 7
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with sc_lt 5
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with sc_lt 4
      end

      result.should == {"name"=> "f3_2_scenarios_3_so"}
    end

    it 'should filter based on the number of scenarios for sc_lte' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

      result = gs.query do
        select name
        from features
        with sc_lte 7
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=>"f2_7_scenarios_2_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with sc_lte 5
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"},
                        {"name"=> "f3_2_scenarios_3_so"}]

      result = gs.query do
        select name
        from features
        with sc_lte 4
      end

      result.should == [{"name"=> "f1_4_scenarios_5_so"}, {"name"=> "f3_2_scenarios_3_so"}]
    end

    it 'should filter on the number of tags on a feature' do

    end
  end

  describe 'filter by tag count' do

    {
        0=>[],
        1=>[],
        2=>{"name"=> "f1_1_tag"},
        3=>[{"name"=> "f1_1_tag"}, {"name"=> "f2_2_tags"}],
        4=>[{"name"=> "f1_1_tag"}, {"name"=> "f2_2_tags"}, {"name"=> "f3_3_tags"}],
        5=>[{"name"=> "f1_1_tag"}, {"name"=> "f2_2_tags"}, {"name"=> "f3_3_tags"}]

    }.each do |number, expected|
      it "should filter features by the number of tags with the 'tc_lt' operator for count of #{number}" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/b"

        result = gs.query do
          select name
          from features
          with tc_lt number
        end

        result.should == expected
      end
    end
  end

  describe 'scenario outline count functions' do
    {
        2=>[{"name"=> "f1_4_scenarios_5_so"}, {"name"=> "f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        3=>[{"name"=> "f1_4_scenarios_5_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        4=>{"name"=> "f1_4_scenarios_5_so"},
        7=>[]

    }.each do |number, expected|
      it "soc_gte filter should filter scenarios for input '#{number}'" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

        result = gs.query do
          select name
          from features
          with soc_gte number
        end

        result.should == expected
      end
    end

    {
        7=>[{"name"=> "f1_4_scenarios_5_so"}, {"name"=> "f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        5=>[{"name"=> "f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        4=>[{"name"=> "f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],

    }.each do |number, expected|
      it "soc_lt filter should filter scenarios for input '#{number}'" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"
        result = gs.query do
          select name
          from features
          with soc_lt number
        end

        result.should == expected
      end
    end


    {
        7=>[{"name"=> "f1_4_scenarios_5_so"}, {"name"=>"f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        5=>[{"name"=> "f1_4_scenarios_5_so"}, {"name"=>"f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
        4=>[{"name"=> "f2_7_scenarios_2_so"}, {"name"=> "f3_2_scenarios_3_so"}],
    }.each do |num, expected|
      it "should filter based on the number of scenarios for soc_lte with input '#{num}'" do
        gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/combined/a"

        result = gs.query do
          select name
          from features
          with soc_lte num
        end

        result.should == expected
      end
    end
  end


  describe 'filter features by name' do
    it 'should filter by name' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with name 'Test2 Feature'
      end

      result.should == {"name"=> "Test2 Feature"}
    end

    it 'should filter by name regexp' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with name /Test2 Feature/
      end

      result.should == {"name"=> "Test2 Feature"}

      result = gs.query do
        select name
        from features
        with name /Feature/
      end

      result.size.should == 3
    end
  end

  describe 'filter features by tag' do
    it 'should filter by a single tag' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@one'
      end

      result.should == [{"name"=> "Test Feature"}, {"name"=>"Test3 Feature"}]

      result = gs.query do
        select name
        from features
        with tags '@two'
      end

      result.should == [{"name"=> "Test2 Feature"}, {"name"=>"Test3 Feature"}]
    end

    it 'should filter by multiple filters' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@two'
        with tags '@one'
      end

      result.should == {"name"=>"Test3 Feature"}
    end

    it 'should filter by a multiple tags' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@one', '@two'
      end

      result.should == {"name"=>"Test3 Feature"}
    end
  end

end
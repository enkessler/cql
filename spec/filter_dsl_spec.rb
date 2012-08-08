require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe 'count functions' do
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

      result.should == [{"name"=> "f1_4_scenarios_5_so"},{"name"=> "f3_2_scenarios_3_so"}]
    end

    it 'should filter based on the number of scenario outlines' do

    end

    it 'should filter based on the combined number of scenario and scenario outlines' do

    end

    it 'should filter on the number of tags on a feature' do

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
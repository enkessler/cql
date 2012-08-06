require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "single value, single results" do
    it 'should get scenario outlines line number' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = gs.query do
        select line
        from scenario_outlines
      end
      result.should == {"line"=>3}
    end

    it 'should get scenario outlines name' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = gs.query do
        select name
        from scenario_outlines
      end
      result.should == {"name"=> "An Outline"}
    end
  end

  describe "single value, multiple results" do
    it 'should get scenario outlines as is when no select criteria given' do
      expected = {"all"=>{"keyword"=>"Scenario Outline",
                            "name"=>"An Outline",
                            "line"=>3, "description"=>"",
                            "id"=>"test-feature;an-outline", "type"=>"scenario_outline",
                            "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                                      {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}],
                            "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>6, "description"=>"", "id"=>"test-feature;an-outline;",
                                          "rows"=>[{"cells"=>["var_a", "var_b"], "line"=>7, "id"=>"test-feature;an-outline;;1"},
                                                   {"cells"=>["1", "a"], "line"=>8, "id"=>"test-feature;an-outline;;2"},
                                                   {"cells"=>["2", "b"], "line"=>9, "id"=>"test-feature;an-outline;;3"},
                                                   {"cells"=>["3", "c"], "line"=>10, "id"=>"test-feature;an-outline;;4"},
                                                   {"cells"=>["4", "d"], "line"=>11, "id"=>"test-feature;an-outline;;5"}]}]}}

      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = gs.query do
        select all
        from scenario_outlines
      end
      result.should == expected

      result = gs.query do
        select everything
        from scenario_outlines
      end
      result.should == expected
    end
  end

  describe "select all" do

  end

  describe "special selectors" do
    it 'should get the full step line scenario outlines' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = gs.query do
        select step_lines
        from scenario_outlines
      end
      result.should == {"step_lines"=> ["Given something happend", "Then I expect something else"]}
    end
  end

  describe "multiple values" do
    it 'should get scenario outlines name and line numbers as a map' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = gs.query do
        select name, line, type, step_lines, id, steps
        from scenario_outlines
      end
      result.should == {'name'=>"An Outline",
                        'line'=>3,
                        'id'=>'test-feature;an-outline',
                        'type'=>'scenario_outline',
                        "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}],
                        "step_lines"=>["Given something happend", "Then I expect something else"]
      }
    end

  end
end
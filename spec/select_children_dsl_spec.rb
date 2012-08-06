require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "single value" do
    it 'should get scenario outlines line number' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select line
        from scenario_outlines
      end
      result.should == {"line"=>3}
    end

    it 'should get scenario outlines name' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select name
        from scenario_outlines
      end
      result.should == {"name"=> "An Outline"}
    end

    it 'should get scenario name' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == [{"name"=> "Testing the slurping"}, {"name"=> "Testing again"},
                        {"name"=> "Testing yet again"}, {"name"=> "Testing yet again part 2"}]
    end

    it 'should get scenario name from multiple feature files' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == [{"name"=> "Has a table"}, {"name"=> "Testing the slurping 1"},
                        {"name"=> "Testing the slurping not to be found"}, {"name"=> "Testing the slurping 2"},
                        {"name"=> "Testing the slurping 3"}, {"name"=> "Testing again"},
                        {"name"=> "Testing yet again"}, {"name"=> "Testing yet again part 2"}]
    end

    it 'should get scenario line number' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select line
        from scenarios
      end
      result.should == [{"line"=> 6}, {"line"=> 11}, {"line"=> 16}, {"line"=> 21}]
    end
  end

  describe "select all" do

  end

  describe "special selectors" do
    it 'should get the full step line scenario outlines' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select step_lines
        from scenario_outlines
      end
      result.should == {"step_lines"=> ["Given something happend", "Then I expect something else"]}
    end
  end

  describe "multiple values" do
    it 'should get scenario outlines name and line numbers as a map' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
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

    it 'should get multiple scenarios as a list of maps' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select line, name
        from scenarios
      end
      result.should == [{'line'=>6, 'name'=>"Testing the slurping"}, {'line'=>11, 'name'=>"Testing again"},
                        {'line'=>16, 'name'=>"Testing yet again"}, {'line'=>21, 'name'=>"Testing yet again part 2"}]
    end
  end
end
require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "single value" do
    it 'should find the feature file name' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.query do
        select name
        from features
      end
      result.should == ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should find the feature description' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple2"
      result = gs.query do
        select description
        from features
      end
      result.should == ["The cat in the hat"]
    end

    it 'should find the feature file uri' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.query do
        select uri
        from features
      end
      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test\_full\.feature/
    end

    it 'should get scenario outlines line number' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"

      result = gs.query do
        select line
        from scenario_outlines
      end

      result[0].should == 3
    end

    it 'should get scenario outlines name' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select name
        from scenario_outlines
      end
      result.should == ["An Outline"]
    end

    it 'should get scenario name' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == ["Testing the slurping", "Testing again", "Testing yet again", "Testing yet again part 2"]
    end

    it 'should get scenario name from multiple feature files' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == ["Has a table", "Testing the slurping 1",
                        "Testing the slurping not to be found", "Testing the slurping 2",
                        "Testing the slurping 3", "Testing again",
                        "Testing yet again", "Testing yet again part 2"]
    end

    it 'should get scenario line number' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select line
        from scenarios
      end
      result.should == [6, 11, 16, 21]
    end
  end

  describe "multiple values" do
    it 'should get scenario outlines name and line numbers as a map' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select name, line, type, steps, id
        from scenario_outlines
      end
      result.should == {'name'=>"An Outline",
                        'line'=>3,
                        'id'=>'test-feature;an-outline',
                        'type'=>'scenario_outline',
                        "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]}
    end

    it 'should get the full step line scenario outlines' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select step_lines
        from scenario_outlines
      end
      result.should == ["Given something happend", "Then I expect something else"]
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
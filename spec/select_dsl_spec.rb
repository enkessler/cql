require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "single value" do
    it 'should find the feature file names' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.query do
        select names
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

    it 'should get scenario outlines names' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select names
        from scenario_outlines
      end
      result.should == ["An Outline"]
    end

    it 'should get scenario names' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select names
        from scenarios
      end
      result.should == ["Testing the slurping", "Testing again", "Testing yet again", "Testing yet again part 2"]
    end

    it 'should get scenario names from multiple feature files' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      result = gr.query do
        select names
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
      result.should == [6,11,16,21]
    end
  end

  describe "multiple values" do
    it 'should get scenario outlines names and line numbers as a map' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      result = gs.query do
        select names, line
        from scenario_outlines
      end
      result.should == {'name'=>"An Outline",
                        'line'=>3}
    end

    #it 'should return a 2D array for feature file names and description for multiple results' do
    #  gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
    #  result = gr.query do
    #    select line, name
    #    from scenarios
    #  end
    #  result.should == [[6,"Testing the slurping"],[11,"Testing again"],
    #                    [16,"Testing yet again"],[21,"Testing yet again part 2"]]
    #end

  end
end
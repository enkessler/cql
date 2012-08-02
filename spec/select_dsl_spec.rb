require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do
  describe "select" do
    it 'should find the feature file names' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.query do
        select names
        from features
      end
      result.should == ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
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

    it 'should get scenario line number' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"
      result = gr.query do
        select line
        from scenarios
      end
      result.should == [5,10,15,20]
    end
  end
end
require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do
  describe "select" do
    it 'should find the feature file names' do
      gs = CQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select names
        from features
      end

      result.should == ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should find the feature file names' do
      gs = CQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select uri
        from features
      end

      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end

    it 'should get scenario outlines as a list' do
      gs = CQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"

      result = gs.query do
        select names
        from scenario_outlines
      end

      result.should == ["An Outline"]
    end

    it 'should get scenario as a list' do
      gr = CQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"

      result = gr.query do
        select names
        from scenarios
      end

      result.should == ["Testing the slurping", "Testing again", "Testing yet again", "Testing yet again part 2"]
    end
  end
end
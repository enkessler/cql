require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_repo"

describe "cql" do

  describe 'filter' do
    it 'should filter by a single tag' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/tagged_features"

      result = gs.query do
        select names
        from features
        with tag '@one'
      end

      result.should == ["Test Feature", "Test3 Feature"]

      result = gs.query do
        select names
        from features
        with tag '@two'
      end

      result.should == ["Test2 Feature", "Test3 Feature"]
    end

    it 'should filter by a multiple tags' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/tagged_features"

      result = gs.query do
        select names
        from features
        with tags '@one', '@two'
      end
      result.should == ["Test3 Feature"]

    end
  end

  describe "select" do
    it 'should find the feature file names' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select names
        from features
      end

      result.should == ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should find the feature file names' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select file_names
        from features
      end

      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end

    it 'should get scenario outlines as a list' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"

      result = gs.query do
        select names
        from scenario_outlines
      end

      result.should == ["An Outline"]
    end

    it 'should get scenario as a list' do
      gr = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"

      result = gr.query do
        select names
        from scenarios
      end

      result.should == ["Testing the slurping", "Testing again", "Testing yet again", "Testing yet again part 2"]
    end
  end
end
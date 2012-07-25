require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_repo"

describe "cql" do

  #describe 'filter' do
  #  it 'should filter by tag' do
  #    gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/tags2"
  #
  #    result = gs.query do
  #      select features.names
  #      where features.tags  = '@two'
  #    end
  #
  #    result.should == ["Has a table", "Blah", "Has a table hmmm", "Blah blah"]
  #  end
  #end

  describe "select" do
    it 'should find the physical file names' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select features.names
      end

      result.should == ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should find the feature file names' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select features.file_names
      end

      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end

    it 'should get scenario outlines as a list' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"

      result = gs.query do
        select scenario_outlines.names
      end

      result.should == ["An Outline"]
    end

    it 'should get scenario as a list' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"

      result = gs.query do
        select scenarios.names
      end

      result.should == ["Testing the slurping", "Testing again","Testing yet again" ,"Testing yet again part 2"]
    end
  end
end
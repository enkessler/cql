require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_slurper"

describe "cql" do

  describe "select" do
    it 'should find the physical files' do
      gs = GQL::GherkinSlurper.new File.dirname(__FILE__) + "/../fixtures/features/simple"

      result = gs.query do
        select features.file_names
      end

      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end

    it 'should get scenario outlines as a list' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"

      result = gs.query do
        select scenario_outlines.names
      end

      result.should == ["An Outline"]
    end

     it 'should get scenario as a list' do
      gs = GQL::GherkinSlurper.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple2"

      result = gs.query do
        select scenarios.names
      end

      result.should == ["Testing the slurping", "Testing again","Testing yet again" ,"Testing yet again part 2"]
    end
  end
end
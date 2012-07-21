require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_slurper"

describe "cql" do

  describe "file parsing" do
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
  end


end
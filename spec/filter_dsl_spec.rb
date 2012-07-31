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

end
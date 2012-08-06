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
      result.should == [{"name"=>"Simple"}, {"name"=>"Test Feature"},
                        {"name"=>"Test2 Feature"}, {"name"=>"Test3 Feature"}]
    end

    it 'should find the feature description' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple2"
      result = gs.query do
        select description
        from features
      end
      result.should == {"description"=>"The cat in the hat"}
    end

    it 'should find the feature file uri' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = gs.query do
        select uri
        from features
      end
      result[0]['uri'].should =~ /simple\.feature/
      result[1]['uri'].should =~ /test\.feature/
      result[2]['uri'].should =~ /test2\.feature/
      result[3]['uri'].should =~ /test\_full\.feature/
    end
  end
end
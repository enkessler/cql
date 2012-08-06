require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "feature" do
    it 'should return multiple feature file names' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple"
      result = gs.query do
        select name
        from features
      end
      result.should == [{"name"=>"Simple"}, {"name"=>"Test Feature"},
                        {"name"=>"Test2 Feature"}, {"name"=>"Test3 Feature"}]
    end

    it 'should return multiple feature file names with associated tags' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"
      result = gs.query do
        select name, tags
        from features
      end
      result.should == [{"name"=>"Simple", "tags"=>nil},
                        {"name"=>"Test Feature", "tags"=>[{"name"=>"@one", "line"=>1}]},
                        {"name"=>"Test2 Feature", "tags"=>[{"name"=>"@two", "line"=>1}]},
                        {"name"=>"Test3 Feature", "tags"=>[{"name"=>"@one", "line"=>1}, {"name"=>"@two", "line"=>1}]}]
    end

    it 'should find the feature description' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple2"
      result = gs.query do
        select description
        from features
      end
      result.should == {"description"=>"The cat in the hat"}
    end

    it 'should find the feature file uri' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple"
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
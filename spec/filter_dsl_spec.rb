require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe 'filter' do
    it 'should filter by a single tag' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@one'
      end

      result.should == [{"name"=> "Test Feature"}, {"name"=>"Test3 Feature"}]

      result = gs.query do
        select name
        from features
        with tags '@two'
      end

      result.should == [{"name"=> "Test2 Feature"}, {"name"=>"Test3 Feature"}]
    end

    #it 'should filter by a multiple tags' do
    #  gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/tagged_features"
    #
    #  result = gs.query do
    #    select name
    #    from features
    #    with tags '@one', '@two'
    #  end
    #
    #  result.should == {"name"=>"Test3 Feature"}
    #end
  end

end
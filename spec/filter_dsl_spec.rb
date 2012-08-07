require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe 'filter features by name' do
    it 'should filter by name' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with name 'Test2 Feature'
      end

      result.should == {"name"=> "Test2 Feature"}
    end

    it 'should filter by name regexp' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with name /Test2 Feature/
      end

      result.should == {"name"=> "Test2 Feature"}
    end
  end

  describe 'filter features by tag' do
    it 'should filter by a single tag' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

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

    it 'should filter by multiple filters' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@two'
        with tags '@one'
      end

      result.should == {"name"=>"Test3 Feature"}
    end

    it 'should filter by a multiple tags' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tagged_features"

      result = gs.query do
        select name
        from features
        with tags '@one', '@two'
      end

      result.should == {"name"=>"Test3 Feature"}
    end
  end

end
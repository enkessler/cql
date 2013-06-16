require 'rspec'
require File.dirname(__FILE__) + "/../lib/cql"

describe "cql" do

  describe 'cql repo is not mutable' do
    it 'should not change between queries' do

      repo = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/got"

      result = repo.query do
        select name
        from scenarios
        with tags '@Lannister'
      end


      result = repo.query do
        select name
        from scenarios
        with line /child/
      end

      result.should == [{"name"=> "Strange relations"},
                        {"name"=> "Bastard Child"}]
    end
  end
end

require 'spec_helper'

describe "cql" do

  describe 'repo' do
    it 'should not change between queries' do

      repo = CQL::Repository.new("#{@feature_fixtures_directory}/got")

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

      expect(result).to eq([{"name" => "Strange relations"},
                            {"name" => "Bastard Child"}])
    end
  end
end

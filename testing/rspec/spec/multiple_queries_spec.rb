require "#{File.dirname(__FILE__)}/spec_helper"


describe "cql" do

  describe 'repo' do
    it 'should not change between queries' do

      repo = CQL::Repository.new("#{@feature_fixtures_directory}/got")

      before_dump = Marshal.dump(repo)

      repo.query do
        select name
        from scenarios
      end

      after_dump = Marshal.dump(repo)


      expect(before_dump).to eq(after_dump)
    end
  end
end

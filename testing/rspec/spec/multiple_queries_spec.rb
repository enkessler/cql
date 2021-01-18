require_relative '../../../environments/rspec_env'


RSpec.describe "cql" do

  describe 'repo' do
    it 'should not change between queries' do

      repo = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/got")

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

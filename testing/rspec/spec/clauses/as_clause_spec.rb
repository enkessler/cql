require_relative '../../../../environments/rspec_env'

RSpec.describe 'an object that uses the DSL' do

  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }

  describe 'as' do

    it 'selectively renames attributes' do
      gherkin = "Feature:

                   Scenario: Test 1
                     * a step

                   Scenario: Test 2
                     * a step
                "

      gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

      results = gs.query do
        select name, source_line
        as source_line => 'foo'
        from scenarios
      end

      expect(results).to eq([{ 'name' => 'Test 1', 'foo' => 3 },
                             { 'name' => 'Test 2', 'foo' => 6 }])
    end

  end

end

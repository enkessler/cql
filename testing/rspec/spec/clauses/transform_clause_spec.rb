require_relative '../../../../environments/rspec_env'


RSpec.describe 'an object that uses the DSL' do


  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe "transform" do

    describe "multiple targets" do

      it 'does not apply more transforms than have been declared' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        results = gs.query do
          select :self, :self, :self
          as thing1, thing2, thing3
          from scenarios
          transform :self => lambda { |thing1| 1 }
          transform :self => lambda { |thing2| 2 }
        end

        expect(results.first).to include('thing1' => 1, 'thing2' => 2)
        expect(results.first).to_not include('thing3' => 1)
        expect(results.first).to_not include('thing3' => 2)
      end

    end

  end

end

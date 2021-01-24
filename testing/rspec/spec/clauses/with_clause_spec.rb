require_relative '../../../../environments/rspec_env'


RSpec.describe 'an object that uses the DSL' do

  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe 'with' do

    it 'knows how to filter selections with certain qualities' do
      expect(dsl_enabled_object).to respond_to(:with)
    end


    describe 'targeted' do

      it 'can handle predefined filters' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect do
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        end.to_not raise_error
      end

      it 'can handle a block filter' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect do
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => ->(_scenario) { true }
          end
        end.to_not raise_error
      end

      it 'correctly filters with a targeted block' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        result = gs.query do
          select name
          from scenarios
          with scenarios => ->(scenario) { scenario.name =~ /king of/ }
        end

        expect(result).to eq([{ 'name' => 'The king of kings' }])
      end

      it 'can handle shorthand targets' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect do
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        end.to_not raise_error
      end

      it 'can handle multiple targets' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect do
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => ->(_scenario) { true },
                 outlines => ->(_outline) { true }
          end
        end.to_not raise_error
      end

    end

  end

end

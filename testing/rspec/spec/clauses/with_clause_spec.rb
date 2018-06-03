require "#{File.dirname(__FILE__)}/../spec_helper"


describe 'an object that uses the DSL' do

  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe 'with' do

    it 'knows how to filter selections with certain qualities' do
      expect(dsl_enabled_object).to respond_to(:with)
    end


    describe 'targeted' do

      it 'can handle predefined filters' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        }.to_not raise_error
      end

      it 'can handle a block filter' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => lambda { |scenario| true }
          end
        }.to_not raise_error
      end

      it 'correctly filters with a targeted block' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        result = gs.query do
          select name
          from scenarios
          with scenarios => lambda { |scenario| scenario.name =~ /king of/ }
        end

        expect(result).to eq([{'name' => 'The king of kings'}])
      end

      it 'can handle shorthand targets' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        }.to_not raise_error
      end

      it 'can handle multiple targets' do
        gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => lambda { |scenario| true },
                 outlines => lambda { |outline| true }
          end
        }.to_not raise_error
      end

    end

  end

end

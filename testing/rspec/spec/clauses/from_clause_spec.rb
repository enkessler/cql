require "#{File.dirname(__FILE__)}/../spec_helper"


describe 'an object that uses the DSL' do


  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe "from" do

    it 'knows from what to select attributes' do
      expect(dsl_enabled_object).to respond_to(:from)
    end

    it 'selects from one or more things' do
      expect(dsl_enabled_object.method(:from).arity).to eq(-1)
    end

    it "can handle an empty 'from' clause" do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      result = gs.query do
        select name
        from
      end

      expect(result).to eq([])
    end

    describe "multiple targets" do

      it 'raises an exception for inapplicable attributes' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect {
          gs.query do
            select name, steps
            from features
            from scenarios
          end
        }.to raise_error(ArgumentError)
      end

    end

    describe 'shorthand' do

      it 'should consider an exact match over a pluralization' do
        plural_class_model = CukeModeler::CqlTestModels.new
        singular_class_model = CukeModeler::CqlTestModel.new

        plural_class_model.attribute_1 = 'plural'
        singular_class_model.attribute_1 = 'singular'
        plural_class_model.children << singular_class_model

        repo = CQL::Repository.new(plural_class_model)

        result = repo.query do
          select attribute_1
          from cql_test_model
        end

        expect(result.first['attribute_1']).to eq('singular')
      end

      it 'raises an exception if the shorthand form of a class cannot be mapped to a real class' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect {
          gs.query do
            select name
            from not_a_real_class
          end
        }.to raise_error(ArgumentError, "Class 'CukeModeler::NotARealClass' does not exist")

      end

      it 'can freely mix shorthand and long-form names' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        # All long-form
        base_result = gs.query do
          select name
          from CukeModeler::Scenario, CukeModeler::Feature
        end

        # All shorthand
        expect(
            gs.query do
              select name
              from scenarios, features
            end
        ).to eq(base_result)

        # A mix of both
        expect(
            gs.query do
              select name
              from CukeModeler::Scenario, features
            end
        ).to eq(base_result)
      end

    end


    describe 'special scopes' do

      it 'understands the :all scope' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect { gs.query do
          select :model
          from :all
        end
        }.to_not raise_error
      end

      it 'queries from all models when scoped to :all' do
        model_1 = CukeModeler::CqlTestModel.new
        model_2 = CukeModeler::CqlTestModel.new
        model_3 = CukeModeler::CqlTestModel.new

        model_1.children << model_2
        model_1.children << model_3

        repo = CQL::Repository.new(model_1)

        result = repo.query do
          select :model
          from :all
        end

        expect(result).to match_array([{:model => model_1},
                                       {:model => model_2},
                                       {:model => model_3}])
      end

    end

  end


end

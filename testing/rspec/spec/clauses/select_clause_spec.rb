require "#{File.dirname(__FILE__)}/../spec_helper"


describe 'an object that uses the DSL' do


  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }

  describe "select" do

    it 'knows how to select attributes' do
      expect(dsl_enabled_object).to respond_to(:select)
    end

    it 'selects one or more attributes' do
      expect(dsl_enabled_object.method(:select).arity).to eq(-1)
    end

    it 'correctly selects a single attribute from a model' do
      model = CukeModeler::CqlTestModel.new
      model.attribute_1 = 'foo'

      repo = CQL::Repository.new(model)

      result = repo.query do
        select attribute_1
        from cql_test_model
      end


      expect(result).to eq([{'attribute_1' => 'foo'}])
    end

    it 'correctly selects multiple attributes from a model' do
      model = CukeModeler::CqlTestModel.new
      model.attribute_1 = 'foo'
      model.attribute_2 = 'bar'

      repo = CQL::Repository.new(model)

      result = repo.query do
        select attribute_1, attribute_2
        from cql_test_model
      end


      expect(result).to eq([{'attribute_1' => 'foo',
                             'attribute_2' => 'bar'}])
    end


    describe 'special attributes' do

      it 'understands the :model attribute' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect { gs.query do
          select :model
          from features
        end
        }.to_not raise_error
      end

      it 'interprets :model in the same manner that it interprets :self' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        self_result = gs.query do
          select :self
          from features
        end

        model_result = gs.query do
          select :model
          from features
        end

        # Only checking the values of the results because they will have different :model/:self keys
        expect(model_result.collect { |result| result.values }).to eq(self_result.collect { |result| result.values })
      end

      it 'complains if an unknown special attribute is queried' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect {
          gs.query do
            select :foo
            from scenarios
          end
        }.to raise_error(ArgumentError, ":foo is not a valid attribute for selection.")
      end

      it 'uses the :self attribute by default' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        default_result = gs.query do
          select
          from features
        end

        self_result = gs.query do
          select :self
          from features
        end

        expect(self_result).to eq(default_result)
      end

    end


    it 'complains if an unknown normal attribute is queried' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      expect {
        gs.query do
          select steps
          from features
        end
      }.to raise_error(ArgumentError, "'steps' is not a valid attribute for selection from a 'CukeModeler::Feature'.")
    end


    describe "multiple selections" do

      it 'can freely mix empty selections and attribute selections' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        base_result = gs.query do
          select :self
          select name
          select :self
          as 'foo', 'bar', 'baz'
          from scenarios
        end


        expect(
            gs.query do
              select
              select name
              select
              as 'foo', 'bar', 'baz'
              from scenarios
            end
        ).to eq(base_result)
      end

    end


    describe 'duplicate selections' do

      let(:warning_message) { "Multiple selections made without using an 'as' clause\n" }

      it "warns if the same attribute is selected more than once without an 'as' clause being used" do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect {
          gs.query do
            select :model, :model, :model
            from :all
          end
        }.to output(warning_message).to_stderr
      end

      it "does not warn if the same attribute is selected more than once and an 'as' clause is used" do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

        expect {
          gs.query do
            select :model, :model, :model
            # Usage of the clause is sufficient. Not going to try and count the mappings or anything like that.
            as foo
            from :all
          end
        }.to_not output(warning_message).to_stderr
      end

    end

  end

end

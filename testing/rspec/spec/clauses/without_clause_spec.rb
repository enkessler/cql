require_relative '../../../../environments/rspec_env'


RSpec.describe 'an object that uses the DSL' do

  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe 'without' do

    it 'knows how to filter selections without certain qualities' do
      expect(dsl_enabled_object).to respond_to(:without)
    end

    it 'correctly negates a block filter' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      negated_result = gs.query do
        select name
        from scenarios
        with { |scenario| scenario.source_line != 3 }
      end

      without_result = gs.query do
        select name
        from scenarios
        without { |scenario| scenario.source_line == 3 }
      end

      expect(without_result).to eq(negated_result)
    end

    it 'correctly negates a targeted filter' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      negated_result = gs.query do
        select :model
        from features, scenarios
        with scenarios => ->(_scenario) { false }
      end

      without_result = gs.query do
        select :model
        from features, scenarios
        without scenarios => ->(_scenario) { true }
      end

      expect(without_result).to eq(negated_result)
    end


    describe 'negating predefined filters' do

      it 'correctly negates a tag count filter' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tags2")

        negated_result = gs.query do
          select :model
          from scenarios
          with tc lt 2
        end

        without_result = gs.query do
          select :model
          from scenarios
          without tc gt 1
        end

        expect(without_result).to eq(negated_result)
      end

      it 'correctly negates a name filter' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/name_filter")

        negated_result = gs.query do
          select :model
          from scenarios
          with name(/name[^1]/)
        end

        without_result = gs.query do
          select :model
          from scenarios
          without name(/name1/)
        end

        expect(without_result).to eq(negated_result)
      end

      it 'correctly negates a line filter' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_filter")

        negated_result = gs.query do
          select name
          from scenarios
          with line 'green eggs and ham'
        end

        without_result = gs.query do
          select name
          from scenarios
          without line 'some other phrase'
        end

        expect(without_result).to eq(negated_result)
      end

      it 'correctly negates a tag filter' do
        gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tags3")

        negated_result = gs.query do
          select :model
          from scenarios
          with tags '@one'
        end

        without_result = gs.query do
          select :model
          from scenarios
          without tags '@two'
        end

        expect(without_result).to eq(negated_result)
      end

    end

    it 'correctly negates a targeted, predefined filter' do
      gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

      negated_result = gs.query do
        select :model
        from :all
        with scenarios => name(/(?!test)/)
      end

      without_result = gs.query do
        select :model
        from :all
        without scenarios => name(/test/)
      end

      expect(without_result).to eq(negated_result)
    end

    it 'correctly negates multiple filters' do
      gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

      negated_result = gs.query do
        select :model
        from :all
        with scenarios => ->(_scenario) { false },
             outlines => ->(_outline) { false }
        with { |model| !model.is_a?(CukeModeler::Example) }
      end

      without_result = gs.query do
        select :model
        from :all
        # TODO: make using symbols like this work
        # without scenarios: ->(_scenario) { true },
        #         outlines: ->(_outline) { true }
        without scenarios => ->(_scenario) { true },
                outlines => ->(_outline) { true }
        without { |model| model.is_a?(CukeModeler::Example) }
      end

      expect(without_result).to eq(negated_result)
    end

  end

end

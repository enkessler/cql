require 'spec_helper'

describe 'dsl' do


  describe 'clause ordering' do

    it 'handles intermixed clauses' do
      # Clause ordering doesn't matter as long as any given type of clause is ordered correctly with respect to its multiple uses

      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

      results = gs.query do
        with { |thing| thing.tags.include?('@one') }
        as thing1
        transform :self => lambda { |thing1| 1 }
        select :self
        as thing2
        with scenarios => lambda { |scenario| scenario.name =~ /3/ }
        from scenarios
        select :self
        transform :self => lambda { |thing2| 2 }
        select name
      end

      expect(results.first).to eq('thing1' => 1, 'thing2' => 2, 'name' => 'Testing the slurping 3')
    end

  end


  describe "select" do

    describe "multiple selections" do

      it 'should handle an empty selection' do
        skip("It may be useful to be able to return both the underlying object and various attributes on it (which is the probably the intent of this query [assuming that it's not just a typo]) but I can't think of a clean way to do it. Behavior undefined for now.")

        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

        result = gs.query do
          select
          select name
          from features
        end

      end

    end
  end

  describe "from" do

    describe "multiple targets" do

      it 'raises an exception for inapplicable attributes' do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

        expect {
          gs.query do
            select name, steps
            from features
            from scenarios
          end
        }.to raise_error

      end

    end

    describe 'shorthand' do

      it 'should consider an exact match over a pluralization' do
        skip('Not sure how to test this without actually have two classes that are so similarly named. It is a required behavior, but not one worth the hassle of testing until it actually comes up.')
      end

      it 'raises an exception if the shorthand form of a class cannot be mapped to a real class' do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

        expect {
          gs.query do
            select name
            from not_a_real_class
          end
        }.to raise_error(ArgumentError, "Class 'CukeModeler::NotARealClass' does not exist")

      end
    end

  end

  describe "transform" do

    describe "multiple targets" do

      it 'does not apply more transforms than have been declared' do
        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

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


  describe 'with' do

    describe 'targeted' do

      it 'can handle predefined filters' do
        gs = CQL::Repository.new(@feature_fixtures_directory)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        }.to_not raise_error
      end

      it 'can handle a block filter' do
        gs = CQL::Repository.new(@feature_fixtures_directory)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => lambda { |scenario| true }
          end
        }.to_not raise_error
      end

      it 'can handle shorthand targets' do
        gs = CQL::Repository.new(@feature_fixtures_directory)

        expect {
          gs.query do
            select name
            from features, scenarios, outlines
            with scenarios => name(/test/)
          end
        }.to_not raise_error
      end

      it 'can handle multiple targets' do
        gs = CQL::Repository.new(@feature_fixtures_directory)

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

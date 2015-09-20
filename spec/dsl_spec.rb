require 'spec_helper'

describe 'dsl' do
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
end

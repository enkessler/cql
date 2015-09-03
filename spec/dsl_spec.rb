require 'spec_helper'

describe 'dsl' do
  describe "select" do

    describe "multiple selections" do

      it 'should handle an empty selection' do
        skip('What should happen in this case?')

        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

        result = gs.query do
          select
          select name
          from features
        end

        pending
      end

    end
  end

  describe "from" do

    describe "multiple targets" do

      it 'should handle non-existent attributes' do
        skip('What should happen in this case?')

        gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

        result = gs.query do
          select name, steps
          from features
          from scenarios
        end

        pending
      end

    end
  end

  describe 'shorthand' do

    it 'should consider an exact match over a pluralization' do
      skip('Write me')
    end

  end
end
require 'spec_helper'

shared_examples_for 'a name filterable target set' do |target_type, test_data|

  describe 'name filters' do

    it 'should filter by exact name' do
      gs = CQL::Repository.new(test_data[:exact_name][:fixture_location])

      expected_results = test_data[:exact_name][:expected_results]

      expected_results.each do |matched_name, expected|
        result = gs.query do
          select name
          from target_type
          with name matched_name
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter by regexp' do
      gs = CQL::Repository.new(test_data[:regexp][:fixture_location])

      expected_results = test_data[:regexp][:expected_results]

      expected_results.each do |matched_name, expected|
        result = gs.query do
          select name
          from target_type
          with name matched_name
        end

        expect(result).to eq(expected)
      end
    end

  end
end

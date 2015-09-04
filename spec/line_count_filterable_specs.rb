require 'spec_helper'

shared_examples_for 'a line count filterable target set' do |target_type, test_data|

  describe 'line count filters' do


    it "should filter based on 'lc lt'" do
      gs = CQL::Repository.new(test_data[:lc_lt][:fixture_location])

      expected_results = test_data[:lc_lt][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with lc lt number
        end

        expect(result).to match_array(expected)
      end
    end

    it "should filter based on 'lc_lte'" do
      gs = CQL::Repository.new(test_data[:lc_lte][:fixture_location])

      expected_results = test_data[:lc_lte][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with lc lte number
        end

        expect(result).to match_array(expected)
      end
    end

    it "should filter based on 'lc_gt'" do
      gs = CQL::Repository.new(test_data[:lc_gt][:fixture_location])

      expected_results = test_data[:lc_gt][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with lc gt number
        end

        expect(result).to match_array(expected)
      end
    end

    it "should filter based on 'lc_gte'" do
      gs = CQL::Repository.new(test_data[:lc_gte][:fixture_location])

      expected_results = test_data[:lc_gte][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with lc gte number
        end

        expect(result).to match_array(expected)
      end
    end

  end
end

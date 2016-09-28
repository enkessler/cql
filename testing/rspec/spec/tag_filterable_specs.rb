require "#{File.dirname(__FILE__)}/spec_helper"


shared_examples_for 'a tag filterable target set' do |target_type, test_data|

  describe 'tag filters' do

    it 'should filter by a single tag' do
      gs = CQL::Repository.new(test_data[:single_tag][:fixture_location])

      expected_results = test_data[:single_tag][:expected_results]

      expected_results.each do |tag, expected|
        result = gs.query do
          select name
          from target_type
          with tags tag
        end

        expect(result).to match_array(expected)
      end
    end

    it 'should filter by a multiple tags' do
      gs = CQL::Repository.new(test_data[:multiple_tags][:fixture_location])

      expected_results = test_data[:multiple_tags][:expected_results]

      expected_results.each do |filter_tags, expected|
        result = gs.query do
          select name
          from target_type
          with tags *filter_tags
        end

        expect(result).to eq(expected)
      end
    end

    it "should filter based on 'tc lt'" do
      gs = CQL::Repository.new(test_data[:tc_lt][:fixture_location])

      expected_results = test_data[:tc_lt][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with tc lt number
        end

        expect(result).to match_array(expected)
      end
    end

    it "should filter features by 'tc lte'" do
      gs = CQL::Repository.new(test_data[:tc_lte][:fixture_location])

      expected_results = test_data[:tc_lte][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with tc lte number
        end

        expect(result).to match_array(expected)
      end
    end


    it "should filter features by 'tc gt'" do
      gs = CQL::Repository.new(test_data[:tc_gt][:fixture_location])

      expected_results = test_data[:tc_gt][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with tc gt number
        end

        expect(result).to match_array(expected)
      end
    end


    it "should filter features by 'tc gte'" do
      gs = CQL::Repository.new(test_data[:tc_gte][:fixture_location])

      expected_results = test_data[:tc_gte][:expected_results]

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from target_type
          with tc gte number
        end

        expect(result).to match_array(expected)
      end
    end
  end

end

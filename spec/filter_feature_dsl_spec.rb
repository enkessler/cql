require 'spec_helper'

describe "feature filters (with)" do
  describe 'scenario outline and scenario count functions (ssoc)' do
    it 'should filter based on ssoc_gt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with ssoc gt number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on ssoc_gte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {1 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          9 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}],
                          10 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with ssoc gte number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on ssoc_lt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {10 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          9 => [{"name" => "f3_2_scenarios_3_so"}],
                          3 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with ssoc lt number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on ssoc_lte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {10 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          9 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          5 => [{"name" => "f3_2_scenarios_3_so"}],
                          4 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with ssoc lte number
        end

        expect(result).to eq(expected)
      end
    end

  end


  describe 'scenario count functions (sc)' do
    it 'should filter based on sc_gt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {2 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with sc gt number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on sc_gte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {2 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          4 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}],
                          3 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}],
                          7 => [{"name" => "f2_7_scenarios_2_so"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with sc gte number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on sc_lt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {
          7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}],
          5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}],
          4 => [{"name" => "f3_2_scenarios_3_so"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with sc lt number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on sc_lte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          4 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with sc lte number
        end

        expect(result).to eq(expected)
      end
    end
  end

  it_behaves_like 'a tag filterable target set', 'features', {:single_tag => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features",
                                                                              :expected_results => {'@one' => [{"name" => "Test Feature"}, {"name" => "Test3 Feature"}],
                                                                                                    '@two' => [{"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}]}},
                                                              :multiple_tags => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features",
                                                                                 :expected_results => {['@one', '@two'] => [{"name" => "Test3 Feature"}]}},
                                                              :tc_lt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b",
                                                                         :expected_results => {0 => [],
                                                                                               1 => [],
                                                                                               2 => [{"name" => "f1_1_tag"}],
                                                                                               3 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}],
                                                                                               4 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                               5 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}]}},
                                                              :tc_lte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b",
                                                                          :expected_results => {0 => [],
                                                                                                1 => [{"name" => "f1_1_tag"}],
                                                                                                2 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}],
                                                                                                3 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                                4 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}]}},
                                                              :tc_gt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b",
                                                                         :expected_results => {0 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                               1 => [{"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                               2 => [{"name" => "f3_3_tags"}],
                                                                                               3 => [],
                                                                                               4 => []}},
                                                              :tc_gte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b",
                                                                          :expected_results => {0 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                                1 => [{"name" => "f1_1_tag"}, {"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                                2 => [{"name" => "f2_2_tags"}, {"name" => "f3_3_tags"}],
                                                                                                3 => [{"name" => "f3_3_tags"}],
                                                                                                4 => [],
                                                                                                5 => []}}
  }

  describe 'scenario outline count functions (soc)' do
    it 'should filter based on soc_gte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {2 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          3 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          4 => [{"name" => "f1_4_scenarios_5_so"}],
                          7 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with soc gte number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on soc_lt' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          5 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          4 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}]}


      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with soc lt number
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter based on soc_lte' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/combined/a")

      expected_results = {7 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          5 => [{"name" => "f1_4_scenarios_5_so"}, {"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}],
                          4 => [{"name" => "f2_7_scenarios_2_so"}, {"name" => "f3_2_scenarios_3_so"}]}


      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from features
          with soc lte number
        end

        expect(result).to eq(expected)
      end
    end
  end

  it_behaves_like 'a name filterable target set', 'features', {:exact_name => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features",
                                                                               :expected_results => {'Test2 Feature' => [{"name" => "Test2 Feature"}]}},
                                                               :regexp => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features",
                                                                           :expected_results => {/Test2 Feature/ => [{"name" => "Test2 Feature"}],
                                                                                                 /Feature/ => [{"name" => "Test Feature"}, {"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}]}}
  }


  it 'should filter by multiple filters' do
    gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

    result = gs.query do
      select name
      from features
      with tags '@two'
      with tags '@one'
    end

    expect(result).to eq([{"name" => "Test3 Feature"}])
  end

end

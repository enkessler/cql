require 'spec_helper'

describe "scenario and outline filters (with)" do


  # todo - seems like this kind of filtering should be available at the scenario level as well as the feature level
  #it_behaves_like 'a name filterable target set', 'scenarios', {:exact_name => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/name_filter",
  #                                                                             :expected_results => {'name1' => [{"name" => "name1"}]}},
  #                                                             :regexp => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/name_filter",
  #                                                                         :expected_results => {/name/ => [{"name" => "name1"},{"name" => "name2"},{"name" => "name3"}],
  #                                                                                               /name1/ => [{"name" => "name1"}]}}
  #}

  it_behaves_like 'a tag filterable target set', 'scenarios', {:single_tag => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tags",
                                                                               :expected_results => {'@one' => [{'name' => 'Next'}, {'name' => 'Another'}]}},

                                                               :multiple_tags => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tags2",
                                                                                  :expected_results => {['@one', '@five'] => [{'name' => 'Next'}]}},

                                                               :tc_lt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tag_count",
                                                                          :expected_results => {0 => [],
                                                                                                1 => [],
                                                                                                2 => [{"name" => "1 tag"}],
                                                                                                3 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                                4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                                5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                               :tc_lte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tag_count",
                                                                           :expected_results => {0 => [],
                                                                                                 1 => [{"name" => "1 tag"}],
                                                                                                 2 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                                 3 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                                 4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                               :tc_gt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tag_count",
                                                                          :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                1 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                2 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                3 => [{"name" => "4 tags"}],
                                                                                                4 => []}},

                                                               :tc_gte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tag_count",
                                                                           :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 1 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 2 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 3 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 4 => [{"name" => "4 tags"}],
                                                                                                 5 => []}}
  }

  it_behaves_like 'a tag filterable target set', 'scenario_outlines', {:single_tag => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tags",
                                                                               :expected_results => {'@one' => [{'name' => 'Next'}, {'name' => 'Another'}]}},

                                                               :multiple_tags => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tags2",
                                                                                  :expected_results => {['@one', '@five'] => [{'name' => 'Next'}]}},

                                                               :tc_lt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tag_count",
                                                                          :expected_results => {0 => [],
                                                                                                1 => [],
                                                                                                2 => [{"name" => "1 tag"}],
                                                                                                3 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                                4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                                5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                               :tc_lte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tag_count",
                                                                           :expected_results => {0 => [],
                                                                                                 1 => [{"name" => "1 tag"}],
                                                                                                 2 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                                 3 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                                 4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                               :tc_gt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tag_count",
                                                                          :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                1 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                2 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                3 => [{"name" => "4 tags"}],
                                                                                                4 => []}},

                                                               :tc_gte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tag_count",
                                                                           :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 1 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 2 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 3 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                 4 => [{"name" => "4 tags"}],
                                                                                                 5 => []}}
  }


  describe 'line count filters' do
    it "should filter based on 'lc_lt'" do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

      expected_results = {0 => [],
                          1 => [],
                          2 => [{"name" => "1 line"}],
                          3 => [{"name" => "1 line"}, {"name" => "2 lines"}],
                          4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
                          5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from scenarios
          with lc lt number
        end

        expect(result).to eq(expected)
      end
    end

    it "should filter based on 'lc_lte'" do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

      expected_results = {0 => [],
                          1 => [{"name" => "1 line"}],
                          2 => [{"name" => "1 line"}, {"name" => "2 lines"}],
                          3 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
                          4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from scenarios
          with lc lte number
        end

        expect(result).to eq(expected)
      end
    end

    it "should filter based on 'lc_gt'" do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

      expected_results = {0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          1 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          2 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
                          3 => [{"name" => "4 lines"}],
                          4 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from scenarios
          with lc gt number
        end

        expect(result).to eq(expected)
      end
    end

    it "should filter based on 'lc_gte'" do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_count")

      expected_results = {0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          1 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          2 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                          3 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
                          4 => [{"name" => "4 lines"}],
                          5 => []}

      expected_results.each do |number, expected|
        result = gs.query do
          select name
          from scenarios
          with lc gte number
        end

        expect(result).to eq(expected)
      end
    end
  end

  describe 'line match filters' do
    it 'should filter by exact line' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      expected_results = {'all match' => [{"name" => "sc1"}, {"name" => "sc2"}],
                          'green eggs and ham' => [{"name" => "sc1"}],
                          'no match' => []}

      expected_results.each do |matched_line, expected|
        result = gs.query do
          select name
          from scenarios
          with line matched_line
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter by regexp' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/line_filter")

      expected_results = {/all/ => [{"name" => "sc1"}, {"name" => "sc2"}],
                          /green/ => [{"name" => "sc1"}],
                          /will not be found/ => []}

      expected_results.each do |matched_line, expected|
        result = gs.query do
          select name
          from scenarios
          with line matched_line
        end

        expect(result).to eq(expected)
      end
    end
  end


#  # Name
#  # Name match
#
#  # Example count
end

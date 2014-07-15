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

  it_behaves_like 'a line count filterable target set', 'scenarios', {:lc_lt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_count",
                                                                                 :expected_results => {0 => [],
                                                                                                       1 => [],
                                                                                                       2 => [{"name" => "1 line"}],
                                                                                                       3 => [{"name" => "1 line"}, {"name" => "2 lines"}],
                                                                                                       4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
                                                                                                       5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]}},
                                                                      :lc_lte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_count",
                                                                                  :expected_results => {0 => [],
                                                                                                        1 => [{"name" => "1 line"}],
                                                                                                        2 => [{"name" => "1 line"}, {"name" => "2 lines"}],
                                                                                                        3 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}],
                                                                                                        4 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                        5 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}]}},
                                                                      :lc_gt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_count",
                                                                                 :expected_results => {0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                       1 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                       2 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                       3 => [{"name" => "4 lines"}],
                                                                                                       4 => []}},
                                                                      :lc_gte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_count",
                                                                                  :expected_results => {0 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                        1 => [{"name" => "1 line"}, {"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                        2 => [{"name" => "2 lines"}, {"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                        3 => [{"name" => "3 lines"}, {"name" => "4 lines"}],
                                                                                                        4 => [{"name" => "4 lines"}],
                                                                                                        5 => []}}}


  it_behaves_like 'a line filterable target set', 'scenarios', {:exact_line => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_filter",
                                                                                :expected_results => {'all match' => [{"name" => "sc1"}, {"name" => "sc2"}],
                                                                                                      'green eggs and ham' => [{"name" => "sc1"}],
                                                                                                      'no match' => []}},
                                                                :regexp => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/line_filter",
                                                                            :expected_results => {/all/ => [{"name" => "sc1"}, {"name" => "sc2"}],
                                                                                                  /green/ => [{"name" => "sc1"}],
                                                                                                  /will not be found/ => []}}}

  #todo - add line filter tests for scenario outlines
  #todo - add line count filter tests for scenario outlines

  #  # Name
  #  # Name match
  #
  #  # Example count
end

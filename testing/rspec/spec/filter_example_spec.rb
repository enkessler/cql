require_relative '../../../environments/rspec_env'


RSpec.describe "example filters (with)" do


  it_behaves_like 'a name filterable target set', 'examples', {:exact_name => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/name_filter",
                                                                               :expected_results => {'name1' => [{"name" => "name1"}]}},
                                                               :regexp => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/name_filter",
                                                                           :expected_results => {/name/ => [{"name" => "name1"}, {"name" => "name2"}, {"name" => "name3"}],
                                                                                                 /name1/ => [{"name" => "name1"}]}}
                                                }

  it_behaves_like 'a tag filterable target set', 'examples', {:single_tag => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tags",
                                                                              :expected_results => {'@one' => [{'name' => 'Next'}, {'name' => 'Another'}]}},

                                                              :multiple_tags => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tags2",
                                                                                 :expected_results => {['@one', '@five'] => [{'name' => 'Next'}]}},

                                                              :tc_lt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tag_count",
                                                                         :expected_results => {0 => [],
                                                                                               1 => [],
                                                                                               2 => [{"name" => "1 tag"}],
                                                                                               3 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                               4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                               5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                              :tc_lte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tag_count",
                                                                          :expected_results => {0 => [],
                                                                                                1 => [{"name" => "1 tag"}],
                                                                                                2 => [{"name" => "1 tag"}, {"name" => "2 tags"}],
                                                                                                3 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}],
                                                                                                4 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                5 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}]}},

                                                              :tc_gt => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tag_count",
                                                                         :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                               1 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                               2 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                               3 => [{"name" => "4 tags"}],
                                                                                               4 => []}},

                                                              :tc_gte => {:fixture_location => "#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tag_count",
                                                                          :expected_results => {0 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                1 => [{"name" => "1 tag"}, {"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                2 => [{"name" => "2 tags"}, {"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                3 => [{"name" => "3 tags"}, {"name" => "4 tags"}],
                                                                                                4 => [{"name" => "4 tags"}],
                                                                                                5 => []}}
                                               }

  it 'should filter by multiple filters' do
    gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/examples/filters/tag_count")

    result = gs.query do
      select name
      from examples
      with tc gt 1
      with tc lt 3
    end

    expect(result).to eq([{"name" => "2 tags"}])
  end

end

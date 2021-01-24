require_relative '../../../environments/rspec_env'


# rubocop:disable Layout/LeadingCommentSpace
RSpec.describe "cql" do

  # describe "file parsing" do
  #   it 'should find the physical files' do
  #     skip("This is possibly no longer be needed")
  #
  #     gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")
  #     result = CQL::MapReduce.uri(gs.parsed_feature_files)
  #
  #     expect(result[0]).to match(/simple\.feature/)
  #     expect(result[1]).to match(/test\.feature/)
  #     expect(result[2]).to match(/test2\.feature/)
  #     expect(result[3]).to match(/test_full\.feature/)
  #   end
  # end

  #it 'should filter by count functions' do
  #  input = [{"keyword"=>"Feature", "name"=>"f1_4_scenarios_5_so", "line"=>1, "description"=>"", "id"=>"f1-4-scenarios-5-so", "uri"=>"C:/Users/jarrod/dev/gql/spec/../fixtures/features/combined/a/f1_4_scenarios_5_so.feature", "elements"=>[{"keyword"=>"Scenario", "name"=>"f1_scen1", "line"=>3, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-scen1", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>4}, {"keyword"=>"Then ", "name"=>"something else", "line"=>5}]}, {"keyword"=>"Scenario", "name"=>"f1_scen2", "line"=>7, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-scen2", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>8}, {"keyword"=>"Then ", "name"=>"something else", "line"=>9}]}, {"keyword"=>"Scenario", "name"=>"f1_scen3", "line"=>11, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-scen3", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>12}, {"keyword"=>"Then ", "name"=>"something else", "line"=>13}]}, {"keyword"=>"Scenario", "name"=>"f1_scen4", "line"=>15, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-scen4", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>16}, {"keyword"=>"Then ", "name"=>"something else", "line"=>17}]}, {"keyword"=>"Scenario Outline", "name"=>"f1_so1", "line"=>19, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so1", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>20}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>22, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so1;", "rows"=>[{"cells"=>["e"], "line"=>23, "id"=>"f1-4-scenarios-5-so;f1-so1;;1"}, {"cells"=>["r"], "line"=>24, "id"=>"f1-4-scenarios-5-so;f1-so1;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f1_so2", "line"=>26, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so2", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>27}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>29, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so2;", "rows"=>[{"cells"=>["e"], "line"=>30, "id"=>"f1-4-scenarios-5-so;f1-so2;;1"}, {"cells"=>["r"], "line"=>31, "id"=>"f1-4-scenarios-5-so;f1-so2;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f1_so3", "line"=>33, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so3", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>34}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>36, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so3;", "rows"=>[{"cells"=>["e"], "line"=>37, "id"=>"f1-4-scenarios-5-so;f1-so3;;1"}, {"cells"=>["r"], "line"=>38, "id"=>"f1-4-scenarios-5-so;f1-so3;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f1_so4", "line"=>40, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so4", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>41}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>43, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so4;", "rows"=>[{"cells"=>["e"], "line"=>44, "id"=>"f1-4-scenarios-5-so;f1-so4;;1"}, {"cells"=>["r"], "line"=>45, "id"=>"f1-4-scenarios-5-so;f1-so4;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f1_so5", "line"=>47, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so5", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>48}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>50, "description"=>"", "id"=>"f1-4-scenarios-5-so;f1-so5;", "rows"=>[{"cells"=>["e"], "line"=>51, "id"=>"f1-4-scenarios-5-so;f1-so5;;1"}, {"cells"=>["r"], "line"=>52, "id"=>"f1-4-scenarios-5-so;f1-so5;;2"}]}]}]},
  #           {"keyword"=>"Feature", "name"=>"f2_7_scenarios_2_so", "line"=>1, "description"=>"", "id"=>"f2-7-scenarios-2-so", "uri"=>"C:/Users/jarrod/dev/gql/spec/../fixtures/features/combined/a/f2_7_scenarios_2_so.feature", "elements"=>[{"keyword"=>"Scenario", "name"=>"f2_scen1", "line"=>3, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen1", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>4}, {"keyword"=>"Then ", "name"=>"something else", "line"=>5}]}, {"keyword"=>"Scenario", "name"=>"f2_scen2", "line"=>7, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen2", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>8}, {"keyword"=>"Then ", "name"=>"something else", "line"=>9}]}, {"keyword"=>"Scenario", "name"=>"f2_scen3", "line"=>11, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen3", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>12}, {"keyword"=>"Then ", "name"=>"something else", "line"=>13}]}, {"keyword"=>"Scenario", "name"=>"f2_scen4", "line"=>15, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen4", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>16}, {"keyword"=>"Then ", "name"=>"something else", "line"=>17}]}, {"keyword"=>"Scenario", "name"=>"f2_scen5", "line"=>19, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen5", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>20}, {"keyword"=>"Then ", "name"=>"something else", "line"=>21}]}, {"keyword"=>"Scenario", "name"=>"f2_scen6", "line"=>23, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen6", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>24}, {"keyword"=>"Then ", "name"=>"something else", "line"=>25}]}, {"keyword"=>"Scenario", "name"=>"f2_scen7", "line"=>27, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-scen7", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>28}, {"keyword"=>"Then ", "name"=>"something else", "line"=>29}]}, {"keyword"=>"Scenario Outline", "name"=>"f2_so1", "line"=>31, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-so1", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>32}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>34, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-so1;", "rows"=>[{"cells"=>["e"], "line"=>35, "id"=>"f2-7-scenarios-2-so;f2-so1;;1"}, {"cells"=>["r"], "line"=>36, "id"=>"f2-7-scenarios-2-so;f2-so1;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f2_so2", "line"=>38, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-so2", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>39}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>41, "description"=>"", "id"=>"f2-7-scenarios-2-so;f2-so2;", "rows"=>[{"cells"=>["e"], "line"=>42, "id"=>"f2-7-scenarios-2-so;f2-so2;;1"}, {"cells"=>["r"], "line"=>43}]}]}]},
  #           {"keyword"=>"Feature", "name"=>"f3_2_scenarios_3_so", "line"=>1, "description"=>"", "id"=>"f3-2-scenarios-3-so", "uri"=>"C:/Users/jarrod/dev/gql/spec/../fixtures/features/combined/a/f3_2_scenarios_3_so.feature", "elements"=>[{"keyword"=>"Scenario", "name"=>"f3_scen1", "line"=>3, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-scen1", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>4}, {"keyword"=>"Then ", "name"=>"something else", "line"=>5}]}, {"keyword"=>"Scenario", "name"=>"f3_scen2", "line"=>7, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-scen2", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>8}, {"keyword"=>"Then ", "name"=>"something else", "line"=>9}]}, {"keyword"=>"Scenario", "name"=>"f3_scen3", "line"=>11, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-scen3", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>12}, {"keyword"=>"Then ", "name"=>"something else", "line"=>13}]}, {"keyword"=>"Scenario Outline", "name"=>"f3_so1", "line"=>15, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so1", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>16}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>18, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so1;", "rows"=>[{"cells"=>["e"], "line"=>19, "id"=>"f3-2-scenarios-3-so;f3-so1;;1"}, {"cells"=>["r"], "line"=>20, "id"=>"f3-2-scenarios-3-so;f3-so1;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f3_so2", "line"=>22, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so2", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>23}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>25, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so2;", "rows"=>[{"cells"=>["e"], "line"=>26, "id"=>"f3-2-scenarios-3-so;f3-so2;;1"}, {"cells"=>["r"], "line"=>27, "id"=>"f3-2-scenarios-3-so;f3-so2;;2"}]}]}, {"keyword"=>"Scenario Outline", "name"=>"f3_so3", "line"=>29, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so3", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"blah <e>", "line"=>30}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>32, "description"=>"", "id"=>"f3-2-scenarios-3-so;f3-so3;", "rows"=>[{"cells"=>["e"], "line"=>33, "id"=>"f3-2-scenarios-3-so;f3-so3;;1"}, {"cells"=>["r"], "line"=>34, "id"=>"f3-2-scenarios-3-so;f3-so3;;2"}]}]}]}]
  #  result = CQL::MapReduce.filter_features(input, {'sc_gt'=>2})
  #  result.size.should == 3
  #
  #  result = CQL::MapReduce.filter_features(input, {'sc_gt'=>0})
  #  result.size.should == 3
  #
  #  result = CQL::MapReduce.filter_features(input, {'sc_gt'=>3})
  #  result.size.should == 2
  #
  #  result = CQL::MapReduce.filter_features(input, {'sc_gt'=>7})
  #  result.size.should == 0
  #
  #  result = CQL::MapReduce.filter_features(input, {'sc_gt'=>4})
  #  result.size.should == 1
  #end

  describe 'filter by tag count' do
    #it 'should filter by tag count' do
    #  input = [
    #      {"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "id"=>"simple", "uri"=>"",
    #       "elements"=>[
    #           {"keyword"=>"Scenario", "name"=>"1 tag", "line"=>4, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>3}], "id"=>"simple;1-tag", "type"=>"scenario"},
    #           {"keyword"=>"Scenario", "name"=>"2 tags", "line"=>12, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>11}, {"name"=>"@two", "line"=>11}], "id"=>"simple;2-tags", "type"=>"scenario"}]},
    #      {"keyword"=>"Feature", "name"=>"Simple2", "line"=>1, "description"=>"", "id"=>"simple", "uri"=>"", "elements"=>[
    #          {"keyword"=>"Scenario", "name"=>"3 tags", "line"=>4, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>3}, {"name"=>"@two", "line"=>3}, {"name"=>"@three", "line"=>3}], "id"=>"simple;3-tags", "type"=>"scenario"},
    #          {"keyword"=>"Scenario", "name"=>"4 tags", "line"=>12, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>11}, {"name"=>"@two", "line"=>11}, {"name"=>"@three", "line"=>11}, {"name"=>"@four", "line"=>11}], "id"=>"simple;4-tags", "type"=>"scenario", }]}
    #  ]
    #
    #  expected = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "id"=>"simple", "uri"=>"",
    #               "elements"=>[
    #                   {"keyword"=>"Scenario", "name"=>"1 tag", "line"=>4, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>3}], "id"=>"simple;1-tag", "type"=>"scenario"},
    #                   {"keyword"=>"Scenario", "name"=>"2 tags", "line"=>12, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>11}, {"name"=>"@two", "line"=>11}], "id"=>"simple;2-tags", "type"=>"scenario"}]},
    #              {"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "id"=>"simple", "uri"=>"", "elements"=>[]}]
    #  CQL::MapReduce.filter_sso2(input, {"tc_lt"=>3}).size.should == expected.size
    #  CQL::MapReduce.filter_sso2(input, {"tc_lt"=>3}).first['elements'].size.should == expected.first['elements'].size
    #  CQL::MapReduce.filter_sso2(input, {"tc_lt"=>3})[1]['elements'].size.should == expected[1]['elements'].size
    #
    #end
  end

  #describe "tags" do
  #  it "retrieve tags from a scenario" do
  #    gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tags2"
  #    CQL::MapReduce.tag_set(gs.parsed_feature_files).sort.should == ["@five", "@four", "@one", "@two"].sort
  #  end
  #
  #  it 'should filter features by tag' do
  #    input = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "tags"=>[{"name"=>"@two", "line"=>1}], "id"=>"simple", "uri"=>"/a/a"},
  #             {"keyword"=>"Feature", "name"=>"Test Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test-feature"},
  #             {"keyword"=>"Feature", "name"=>"Test2 Feature", "line"=>1, "description"=>"", "id"=>"test2-feature"},
  #             {"keyword"=>"Feature", "name"=>"Test3 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test3-feature"}]
  #    result = CQL::MapReduce.filter_features(input, 'tags'=>['@one'])
  #    result.size.should == 2
  #    result[0]['name'].should == "Test Feature"
  #    result[1]['name'].should == "Test3 Feature"
  #  end
  #
  #  it 'should filter by multiple tags' do
  #    input = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "id"=>"simple"},
  #             {"keyword"=>"Feature", "name"=>"Test Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test-feature"},
  #             {"keyword"=>"Feature", "name"=>"Test2 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@two", "line"=>1}], "id"=>"test2-feature"},
  #             {"keyword"=>"Feature", "name"=>"Test3 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}, {"name"=>"@two", "line"=>1}], "id"=>"test3-feature"}]
  #    result = CQL::MapReduce.filter_features(input, 'tags'=>['@one', '@two'])
  #    result.should == [{"keyword"=>"Feature", "name"=>"Test3 Feature",
  #                       "line"=>2, "description"=>"",
  #                       "tags"=>[{"name"=>"@one", "line"=>1},
  #                                {"name"=>"@two", "line"=>1}],
  #                       "id"=>"test3-feature"}]
  #  end
  #end

  describe 'features query' do
    #it 'should find all feature names' do
    #  gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple"
    #  CQL::MapReduce.name(gs.parsed_feature_files).should eql ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    #end

    #it 'should retrieve a full feature' do
    #  gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple"
    #  result = CQL::MapReduce.filter_features(gs.parsed_feature_files, {'feature'=>["Test Feature"]})
    #  result[0]['name'].should == "Test Feature"
    #  result[0]['elements'][0]['name'].should == "Testing the slurping 1"
    #  result[0]['elements'].should == [{"keyword"=>"Scenario", "name"=>"Testing the slurping 1", "line"=>3,
    #                                    "description"=>"", "id"=>"test-feature;testing-the-slurping-1", "type"=>"scenario",
    #                                    "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
    #                                              {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]},
    #                                   {"keyword"=>"Scenario", "name"=>"Testing the slurping not to be found", "line"=>7,
    #                                    "description"=>"", "id"=>"test-feature;testing-the-slurping-not-to-be-found", "type"=>"scenario",
    #                                    "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>8}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>9}]}]
    #end
  end

  #describe 'scenario query' do
  #  it 'should get all scenarios as a list' do
  #    gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
  #    result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=>["Test Feature"], 'what'=>'scenario'})
  #    result.should == [{"keyword"=>"Scenario", "name"=>"A Scenario", "line"=>13, "description"=>"", "id"=>"test-feature;a-scenario", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>14}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>15}]}]
  #  end
  #end
  #
  #describe 'scenario outline query' do
  #  it 'should get scenario outlines as a list' do
  #    gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
  #    result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=>["Test Feature"], 'what'=> 'scenario'})
  #    result.should == [{"keyword"=>"Scenario", "name"=>"A Scenario", "line"=>13, "description"=>"", "id"=>"test-feature;a-scenario", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>14}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>15}]}]
  #
  #    result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=> ["Test Feature"], 'what'=> 'scenario_outline'})
  #    result.should == [{"keyword"=>"Scenario Outline", "name"=>"An Outline", "line"=>3, "description"=>"", "id"=>"test-feature;an-outline", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>6, "description"=>"", "id"=>"test-feature;an-outline;", "rows"=>[{"cells"=>["var_a", "var_b"], "line"=>7, "id"=>"test-feature;an-outline;;1"}, {"cells"=>["1", "a"], "line"=>8, "id"=>"test-feature;an-outline;;2"}, {"cells"=>["2", "b"], "line"=>9, "id"=>"test-feature;an-outline;;3"}, {"cells"=>["3", "c"], "line"=>10, "id"=>"test-feature;an-outline;;4"}, {"cells"=>["4", "d"], "line"=>11, "id"=>"test-feature;an-outline;;5"}]}]}]
  #  end
  #end

end
# rubocop:enable Layout/LeadingCommentSpace

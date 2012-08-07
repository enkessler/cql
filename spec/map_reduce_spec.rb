require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "cql" do

  describe "file parsing" do
    it 'should find the physical files' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple"
      result = CQL::MapReduce.uri(gs.parsed_feature_files)
      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end
  end

  describe "tags" do
    it "retrieve tags from a scenario" do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/tags2"
      CQL::MapReduce.tag_set(gs.parsed_feature_files).sort.should == ["@five", "@four", "@one", "@two"].sort
    end

    it 'should filter features by tag' do
      input = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "tags"=>[{"name"=>"@two", "line"=>1}], "id"=>"simple", "uri"=>"/a/a"},
               {"keyword"=>"Feature", "name"=>"Test Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test-feature"},
               {"keyword"=>"Feature", "name"=>"Test2 Feature", "line"=>1, "description"=>"", "id"=>"test2-feature"},
               {"keyword"=>"Feature", "name"=>"Test3 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test3-feature"}]
      result = CQL::MapReduce.filter_features(input, 'tags'=>['@one'])
      result.size.should == 2
      result[0]['name'].should == "Test Feature"
      result[1]['name'].should == "Test3 Feature"
    end

    it 'should filter by multiple tags' do
      input = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "id"=>"simple"},
               {"keyword"=>"Feature", "name"=>"Test Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test-feature"},
               {"keyword"=>"Feature", "name"=>"Test2 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@two", "line"=>1}], "id"=>"test2-feature"},
               {"keyword"=>"Feature", "name"=>"Test3 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}, {"name"=>"@two", "line"=>1}], "id"=>"test3-feature"}]
      result = CQL::MapReduce.filter_features(input, 'tags'=>['@one', '@two'])
      result.should == [{"keyword"=>"Feature", "name"=>"Test3 Feature",
                             "line"=>2, "description"=>"",
                             "tags"=>[{"name"=>"@one", "line"=>1},
                                      {"name"=>"@two", "line"=>1}],
                             "id"=>"test3-feature"}]
    end
  end

  describe 'features query' do
    it 'should find all feature names' do
      gs = CQL::Repository.new File.dirname(__FILE__) + "/../fixtures/features/scenario/simple"
      CQL::MapReduce.name(gs.parsed_feature_files).should eql ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should retrieve a full feature' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple"
      result = CQL::MapReduce.filter_features(gs.parsed_feature_files, {'feature'=>["Test Feature"]})
      result[0]['name'].should == "Test Feature"
      result[0]['elements'][0]['name'].should == "Testing the slurping 1"
      result[0]['elements'].should == [{"keyword"=>"Scenario", "name"=>"Testing the slurping 1", "line"=>3,
                                     "description"=>"", "id"=>"test-feature;testing-the-slurping-1", "type"=>"scenario",
                                     "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                                               {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]},
                                    {"keyword"=>"Scenario", "name"=>"Testing the slurping not to be found", "line"=>7,
                                     "description"=>"", "id"=>"test-feature;testing-the-slurping-not-to-be-found", "type"=>"scenario",
                                     "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>8}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>9}]}]
    end
  end

  describe 'scenario query' do
    it 'should get all scenarios as a list' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=>["Test Feature"], 'what'=>'scenario'})
      result.should == [{"keyword"=>"Scenario", "name"=>"A Scenario", "line"=>13, "description"=>"", "id"=>"test-feature;a-scenario", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>14}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>15}]}]
    end
  end

  describe 'scenario outline query' do
    it 'should get scenario outlines as a list' do
      gs = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines/basic"
      result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=>["Test Feature"], 'what'=> 'scenario'})
      result.should == [{"keyword"=>"Scenario", "name"=>"A Scenario", "line"=>13, "description"=>"", "id"=>"test-feature;a-scenario", "type"=>"scenario", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>14}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>15}]}]

      result = CQL::MapReduce.filter_sso(gs.parsed_feature_files, {'feature'=> ["Test Feature"], 'what'=> 'scenario_outline'})
      result.should == [{"keyword"=>"Scenario Outline", "name"=>"An Outline", "line"=>3, "description"=>"", "id"=>"test-feature;an-outline", "type"=>"scenario_outline", "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}], "examples"=>[{"keyword"=>"Examples", "name"=>"", "line"=>6, "description"=>"", "id"=>"test-feature;an-outline;", "rows"=>[{"cells"=>["var_a", "var_b"], "line"=>7, "id"=>"test-feature;an-outline;;1"}, {"cells"=>["1", "a"], "line"=>8, "id"=>"test-feature;an-outline;;2"}, {"cells"=>["2", "b"], "line"=>9, "id"=>"test-feature;an-outline;;3"}, {"cells"=>["3", "c"], "line"=>10, "id"=>"test-feature;an-outline;;4"}, {"cells"=>["4", "d"], "line"=>11, "id"=>"test-feature;an-outline;;5"}]}]}]
    end
  end

end
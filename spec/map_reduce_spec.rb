require 'rspec'
require File.dirname(__FILE__) + "/../lib/" + "gherkin_repo"

describe "cql" do

  describe "file parsing" do
    it 'should find the physical files' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      result = GQL::MapReduce.uri(gs.parsed_feature_files)
      result[0].should =~ /simple\.feature/
      result[1].should =~ /test\.feature/
      result[2].should =~ /test2\.feature/
      result[3].should =~ /test_full\.feature/
    end
  end

  describe "tags" do
    it "retrieve tags from a scenario" do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/tags2"
      GQL::MapReduce.tags(gs.parsed_feature_files).sort.should == ["@five", "@four", "@one", "@two"].sort
    end

    it 'should filter features by tag' do
      input = [{"keyword"=>"Feature", "name"=>"Simple", "line"=>1, "description"=>"", "tags"=>[{"name"=>"@two", "line"=>1}], "id"=>"simple", "uri"=>"/a/a"},
              {"keyword"=>"Feature", "name"=>"Test Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test-feature"},
              {"keyword"=>"Feature", "name"=>"Test2 Feature", "line"=>1, "description"=>"", "id"=>"test2-feature"},
              {"keyword"=>"Feature", "name"=>"Test3 Feature", "line"=>2, "description"=>"", "tags"=>[{"name"=>"@one", "line"=>1}], "id"=>"test3-feature"}]
      result = GQL::MapReduce.filter_features_by_tag(input, '@one')
      result.size.should == 2
      result[0]['name'].should == "Test Feature"
      result[1]['name'].should == "Test3 Feature"
    end

  end

  describe 'features query' do
    it 'should find all feature names' do
      gs = GQL::GherkinRepository.new File.dirname(__FILE__) + "/../fixtures/features/simple"
      GQL::MapReduce.overview(gs.parsed_feature_files).should eql ["Simple", "Test Feature", "Test2 Feature", "Test3 Feature"]
    end

    it 'should filter by a scenario by feature and then by tag' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Not here", "@three").should == []
    end

    it 'should retrieve a full feature' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      result = GQL::MapReduce.find_feature(gs.parsed_feature_files, "Test Feature")
      result['name'].should == "Test Feature"
      result['elements'][0]['name'].should == "Testing the slurping"
      result['elements'].should == [{"keyword"=>"Scenario", "name"=>"Testing the slurping", "line"=>3,
                                "description"=>"", "id"=>"test-feature;testing-the-slurping", "type"=>"scenario",
                                "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                                          {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]},
                               {"keyword"=>"Scenario", "name"=>"Testing the slurping not to be found", "line"=>7,
                                "description"=>"", "id"=>"test-feature;testing-the-slurping-not-to-be-found", "type"=>"scenario",
                                "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>8}, {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>9}]}]
    end
  end

  describe 'scenario query' do
    it 'should get all scenarios as a list' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      GQL::MapReduce.scenarios_from_feature(gs.parsed_feature_files,"Test Feature").should == ["A Scenario"]
    end

    it 'should get a full scenario' do
      simple_path = File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/simple"
      gs = GQL::GherkinRepository.new simple_path
      expected = {"keyword"=>"Scenario", "name"=>"Testing the slurping", "line"=>3,
                  "description"=>"", "id"=>"test-feature;testing-the-slurping", "type"=>"scenario",
                  "steps"=>[{"keyword"=>"Given ", "name"=>"something happend", "line"=>4},
                            {"keyword"=>"Then ", "name"=>"I expect something else", "line"=>5}]}
      GQL::MapReduce.scenario(gs.parsed_feature_files,"Test Feature", "Testing the slurping").should == expected
    end

    it 'should find scenarios by a single tag' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags"
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", true, "@one").should == ['Next', 'Another']
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", true,"@two").should == ['Has a table', 'Blah']

      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", true, "@one").should == ['Next', 'Another']
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", true, "@two").should == ['Has a table', 'Blah']
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple 2", true, "@one").should == ['Next', 'Another']
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple 2", true, "@two").should == ['Has a table hmmm', 'Blah blah']

      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", true, "@three").should == []

    end

    it 'should find scenarios that do not have a specified tag' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags"
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple", false,"@one").should == ['Has a table', 'Blah', 'Yet Another']
      #GQL::MapReduce.scenario_by_feature_wo_tag(gs.parsed_feature_files, "Simple", "@two").should == ['Has a table', 'Blah']
    end

    it 'should find scenarios by multiple tags' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/tags2"
      GQL::MapReduce.scenario_by_feature_and_tag(gs.parsed_feature_files, "Simple 2", true, "@two", "@four").should == ['Has a table hmmm']
    end

    it 'should retrieve the table data' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/table"
      expected = {"keyword"=>"Scenario", "name"=>"Has a table", "line"=>3, "description"=>"", "id"=>"simple;has-a-table", "type"=>"scenario",
                  "steps"=>[{"keyword"=>"Given ", "name"=>"Something", "line"=>4,
                             "rows"=>[{"cells"=>["a", "a"], "line"=>5},
                                      {"cells"=>["s", "a"], "line"=>6}, {"cells"=>["s", "s"], "line"=>7}]},
                            {"keyword"=>"Then ", "name"=>"something else", "line"=>8}]}
      GQL::MapReduce.scenario(gs.parsed_feature_files, "Simple", "Has a table").should == expected
    end
  end

  describe 'scenario outline query' do
    it 'should get scenario outlines as a list' do
      gs = GQL::GherkinRepository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scen_outlines"
      GQL::MapReduce.scenarios_from_feature(gs.parsed_feature_files,"Test Feature").should == ["A Scenario"]
      GQL::MapReduce.scenario_outlines_from_feature(gs.parsed_feature_files, "Test Feature").should == ["An Outline"]
    end
  end

end
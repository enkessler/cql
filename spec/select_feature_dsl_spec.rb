require 'spec_helper'

describe "select" do
  describe "from features" do

    it 'should return names from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

      result = gs.query do
        select name
        from features
      end

      expect(result).to eq([{"name" => "Simple"}, {"name" => "Test Feature"},
                            {"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}])
    end

    it 'should return descriptions from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select description_text
        from features
      end

      expect(result).to eq([{"description_text" => "The cat in the hat"}])
    end

    it 'should return paths from from feature files' do
      repo_path = "#{@feature_fixtures_directory}/scenario/simple"
      gs = CQL::Repository.new(repo_path)

      result = gs.query do
        select path
        from feature_files
      end

      expect(result[0]['path']).to eq("#{repo_path}/simple.feature")
      expect(result[1]['path']).to eq("#{repo_path}/test.feature")
      expect(result[2]['path']).to eq("#{repo_path}/test2.feature")
      expect(result[3]['path']).to eq("#{repo_path}/test_full.feature")
    end

    it 'should return tags from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select tags
        from features
      end

      expect(result).to eq([{"tags" => []},
                            {"tags" => ["@one"]},
                            {"tags" => ["@two"]},
                            {"tags" => ["@one", "@two"]}])
    end


    it 'should return multiple things from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name, tags
        from features
      end

      expect(result).to eq([{"name" => "Simple", "tags" => []},
                            {"name" => "Test Feature", "tags" => ["@one"]},
                            {"name" => "Test2 Feature", "tags" => ["@two"]},
                            {"name" => "Test3 Feature", "tags" => ["@one", "@two"]}])
    end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

      result = gr.query do
        select name
        from features
      end

      expect(result).to eq([{"name" => "f1_1_tag"},
                            {"name" => "f2_2_tags"},
                            {"name" => "f3_3_tags"}])
    end

    it 'should return multiple features as a list of maps' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/combined/b")

      result = gr.query do
        select name
        from features
      end

      expect(result).to eq([{"name" => "f1_1_tag"},
                            {"name" => "f2_2_tags"},
                            {"name" => "f3_3_tags"}])
    end

    it 'should return ids from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select raw_element
        as id
        transform 'raw_element' => lambda { |element| element['id'] }
        from features
      end

      expect(result).to eq([{"id" => "test3-feature"}])
    end

    it "should return all, complete, everything from features" do
      skip("Probably going to get rid of these predefined methods since a simple query can get the same information")

      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      expected = [{"all" => {"keyword" => "Feature",
                             "name" => "Test3 Feature",
                             "line" => 2,
                             "description" => "The cat in the hat",
                             "tags" => [{"name" => "@top-tag", "line" => 1}],
                             "id" => "test3-feature",
                             "uri" => "fake_file.txt",
                             "elements" => [{"keyword" => "Scenario",
                                             "name" => "Testing the slurping",
                                             "line" => 6,
                                             "description" => "",
                                             "tags" => [{"name" => "@one", "line" => 5}],
                                             "id" => "test3-feature;testing-the-slurping",
                                             "type" => "scenario",
                                             "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 7},
                                                         {"keyword" => "Then ", "name" => "I expect something else", "line" => 8}]},
                                            {"keyword" => "Scenario",
                                             "name" => "Testing again",
                                             "line" => 11,
                                             "description" => "",
                                             "tags" => [{"name" => "@two", "line" => 10}],
                                             "id" => "test3-feature;testing-again",
                                             "type" => "scenario",
                                             "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 12},
                                                         {"keyword" => "Then ", "name" => "I expect something else", "line" => 13}]},
                                            {"keyword" => "Scenario",
                                             "name" => "Testing yet again",
                                             "line" => 16,
                                             "description" => "",
                                             "tags" => [{"name" => "@one", "line" => 15}],
                                             "id" => "test3-feature;testing-yet-again",
                                             "type" => "scenario",
                                             "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 17},
                                                         {"keyword" => "Then ", "name" => "I expect something else", "line" => 18}]},
                                            {"keyword" => "Scenario",
                                             "name" => "Testing yet again part 2",
                                             "line" => 21,
                                             "description" => "",
                                             "tags" => [{"name" => "@one", "line" => 20}, {"name" => "@two", "line" => 20}],
                                             "id" => "test3-feature;testing-yet-again-part-2",
                                             "type" => "scenario",
                                             "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 22},
                                                         {"keyword" => "Then ", "name" => "I expect something else", "line" => 23}]}]}}]

      result = gr.query do
        select all
        from features
      end
      expect(result).to eq(expected)

      result = gr.query do
        select complete
        from features
      end
      expect(result).to eq(expected)

      result = gr.query do
        select everything
        from features
      end
      expect(result).to eq(expected)
    end

#    it 'should return simplified tags' do
#      skip
#
#      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")
#      result = gs.query do
#        select name, basic_tag
#        from features
#      end
#
#      expect(result).to eq([{"tags" => nil},
#                            {"tags" => "@one"},
#                            {"tags" => "@two"},
#                            "tags" => "@two"])
#    end
  end
end

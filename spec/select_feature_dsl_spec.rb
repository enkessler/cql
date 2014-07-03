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
        select description
        from features
      end

      expect(result).to eq([{"description" => "The cat in the hat"}])
    end

    it 'should return uris from features' do
      repo_path = "#{@feature_fixtures_directory}/scenario/simple"
      gs = CQL::Repository.new(repo_path)

      result = gs.query do
        select uri
        from features
      end

      expect(result[0]['uri']).to eq("#{repo_path}/simple.feature")
      expect(result[1]['uri']).to eq("#{repo_path}/test.feature")
      expect(result[2]['uri']).to eq("#{repo_path}/test2.feature")
      expect(result[3]['uri']).to eq("#{repo_path}/test_full.feature")
    end

    it 'should return tags from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select tags
        from features
      end

      expect(result).to eq([{"tags" => nil},
                            {"tags" => [{"name" => "@one", "line" => 1}]},
                            {"tags" => [{"name" => "@two", "line" => 1}]},
                            {"tags" => [{"name" => "@one", "line" => 1}, {"name" => "@two", "line" => 1}]}])
    end


    it 'should return multiple things from features' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")

      result = gs.query do
        select name, tags
        from features
      end

      expect(result).to eq([{"name" => "Simple", "tags" => nil},
                            {"name" => "Test Feature", "tags" => [{"name" => "@one", "line" => 1}]},
                            {"name" => "Test2 Feature", "tags" => [{"name" => "@two", "line" => 1}]},
                            {"name" => "Test3 Feature", "tags" => [{"name" => "@one", "line" => 1}, {"name" => "@two", "line" => 1}]}])
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

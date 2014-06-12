require 'spec_helper'

describe "select" do
  describe "feature" do
    it 'should return multiple feature file names' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")
      result = gs.query do
        select name
        from features
      end

      expect(result).to eq([{"name" => "Simple"}, {"name" => "Test Feature"},
                            {"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}])
    end

    it 'should find the feature description' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gs.query do
        select description
        from features
      end

      expect(result).to eq([{"description" => "The cat in the hat"}])
    end

    it 'should find the feature file uri' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")
      result = gs.query do
        select uri
        from features
      end

      expect(result[0]['uri']).to match(/simple\.feature/)
      expect(result[1]['uri']).to match(/test\.feature/)
      expect(result[2]['uri']).to match(/test2\.feature/)
      expect(result[3]['uri']).to match(/test\_full\.feature/)
    end

    it 'should return multiple feature file names with associated tags' do
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

    it 'should return simplified tags' do
      skip

      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tagged_features")
      result = gs.query do
        select name, basic_tag
        from features
      end

      expect(result).to eq([{"tags" => nil},
                            {"tags" => "@one"},
                            {"tags" => "@two"},
                            "tags" => "@two"])
    end
  end
end

require "#{File.dirname(__FILE__)}/spec_helper"


describe "select" do
  describe "from features" do

    it 'should return names from features' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      result = gs.query do
        select name
        from features
      end

      expect(result).to match_array([{"name" => "Simple"}, {"name" => "Test Feature"},
                                     {"name" => "Test2 Feature"}, {"name" => "Test3 Feature"}])
    end

    # it 'should return descriptions from features' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple2")
    #
    #   result = gs.query do
    #     select description_text
    #     from features
    #   end
    #
    #   expect(result).to eq([{"description_text" => "The cat in the hat"}])
    # end

    it 'should return paths from from feature files' do
      repo_path = "#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple"
      gs = CQL::Repository.new(repo_path)

      result = gs.query do
        select path
        from feature_files
      end

      expect(result).to match_array([{'path' => "#{repo_path}/simple.feature"},
                                     {'path' => "#{repo_path}/test.feature"},
                                     {'path' => "#{repo_path}/test2.feature"},
                                     {'path' => "#{repo_path}/test_full.feature"}])
    end

    # it 'should return tags from features' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features")
    #
    #   result = gs.query do
    #     select tags
    #     from features
    #   end
    #
    #   expect(result).to match_array([{"tags" => []},
    #                                  {"tags" => ["@one"]},
    #                                  {"tags" => ["@two"]},
    #                                  {"tags" => ["@one", "@two"]}])
    # end
    #
    #
    # it 'should return multiple things from features' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/tagged_features")
    #
    #   result = gs.query do
    #     select name, tags
    #     from features
    #   end
    #
    #   expect(result).to match_array([{"name" => "Simple", "tags" => []},
    #                                  {"name" => "Test Feature", "tags" => ["@one"]},
    #                                  {"name" => "Test2 Feature", "tags" => ["@two"]},
    #                                  {"name" => "Test3 Feature", "tags" => ["@one", "@two"]}])
    # end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b")

      result = gr.query do
        select name
        from features
      end

      expect(result).to match_array([{"name" => "f1_1_tag"},
                                     {"name" => "f2_2_tags"},
                                     {"name" => "f3_3_tags"}])
    end

    it 'should return multiple features as a list of maps' do
      gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/combined/b")

      result = gr.query do
        select name
        from features
      end

      expect(result).to match_array([{"name" => "f1_1_tag"},
                                     {"name" => "f2_2_tags"},
                                     {"name" => "f3_3_tags"}])
    end

    # it 'should return ids from features' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple2")
    #
    #   result = gs.query do
    #     select raw_element
    #     as 'id'
    #     transform 'raw_element' => lambda { |element| element['id'] }
    #     from features
    #   end
    #
    #   expect(result).to eq([{"id" => "test3-feature"}])
    # end

  end
end

require_relative '../../../environments/rspec_env'


RSpec.describe "select" do
  describe 'from scenario_outlines' do

    # it 'should return tags from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tags2")
    #
    #   result = gs.query do
    #     select tags
    #     from outlines
    #   end
    #
    #   expect(result).to match_array([{"tags" => ["@two"]},
    #                                  {"tags" => ["@one"]},
    #                                  {"tags" => []},
    #                                  {"tags" => ["@two"]},
    #                                  {"tags" => ["@one"]},
    #                                  {"tags" => ["@two", "@four"]},
    #                                  {"tags" => ["@one", "@five"]},
    #                                  {"tags" => []},
    #                                  {"tags" => ["@two"]},
    #                                  {"tags" => ["@one"]}])
    # end
    #
    # it 'should return descriptions from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/multiple_examples")
    #
    #   result = gs.query do
    #     select description_text
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"description_text" => ""}, {"description_text" => "\nOutline description."}])
    # end
    #

    it 'should return lines from scenario outlines' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")

      result = gs.query do
        select source_line
        from outlines
      end

      expect(result).to eq([{ "source_line" => 3 }])
    end

    it 'should return names from scenario outlines' do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")

      result = gs.query do
        select name
        from outlines
      end

      expect(result).to eq([{ "name" => "An Outline" }])
    end

    # it 'should return types from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #
    #   result = gs.query do
    #     select raw_element
    #     as 'type'
    #     transform 'raw_element' => lambda { |element| element['type'] }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"type" => "scenario_outline"}])
    # end
    #
    # it 'should return step lines from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #
    #   result = gs.query do
    #     select raw_element
    #     as step_lines
    #     transform 'raw_element' => lambda { |element| element['steps'].collect { |step| step['keyword'] + step['name'] } }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"step_lines" => ["Given something happend", "Then I expect something else"]}])
    # end
    #
    # it 'should return ids from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #
    #   result = gs.query do
    #     select raw_element
    #     as 'id'
    #     transform 'raw_element' => lambda { |element| element['id'] }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"id" => "test-feature;an-outline"}])
    # end
    #
    # it 'should return steps from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #
    #   result = gs.query do
    #     select raw_element
    #     as steps
    #     transform 'raw_element' => lambda { |element| element['steps'] }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 4}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 5}]}])
    # end
    #
    #
    # it 'should return multiple things from scenario outlines' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/multiple_examples")
    #
    #   result = gs.query do
    #     select name, tags
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"name" => "An Outline", "tags" => []},
    #                         {"name" => "An Outline with everything", "tags" => ["@outline_tag"]}])
    # end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/filters/tags2")

      result = gr.query do
        select name
        from outlines
      end

      expect(result).to match_array([{ "name" => "Has a table" },
                                     { "name" => "Next" },
                                     { "name" => "Another" },
                                     { "name" => "Blah" },
                                     { "name" => "Another" },
                                     { "name" => "Has a table hmmm" },
                                     { "name" => "Next" },
                                     { "name" => "Another" },
                                     { "name" => "Blah blah" },
                                     { "name" => "Another" }])
    end

    it 'should return multiple scenario outlines as a list of maps' do
      gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines")

      result = gr.query do
        select name
        from outlines
      end

      expect(result).to be_an_instance_of(Array)

      result.each do |item|
        expect(item).to be_an_instance_of(Hash)
      end
    end

    # it "should return the examples from scenario outlines" do
    #   gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #   result = gr.query do
    #     select raw_element
    #     as examples
    #     transform 'raw_element' => lambda { |element| element['examples'] }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"examples" => [{"keyword" => "Examples", "name" => "", "line" => 6,
    #                                          "description" => "", "id" => "test-feature;an-outline;",
    #                                          "rows" => [{"cells" => ["var_a", "var_b"], "line" => 7, "id" => "test-feature;an-outline;;1"},
    #                                                     {"cells" => ["1", "a"], "line" => 8, "id" => "test-feature;an-outline;;2"},
    #                                                     {"cells" => ["2", "b"], "line" => 9, "id" => "test-feature;an-outline;;3"},
    #                                                     {"cells" => ["3", "c"], "line" => 10, "id" => "test-feature;an-outline;;4"},
    #                                                     {"cells" => ["4", "d"], "line" => 11, "id" => "test-feature;an-outline;;5"}]}]}])
    # end

    # it "should return multiple examples used for a single scenario outline" do
    #   gr = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/multiple_examples")
    #   result = gr.query do
    #     select raw_element
    #     as examples
    #     transform 'raw_element' => lambda { |element| element['examples'] }
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{"examples" => [{"keyword" => "Examples", "name" => "One", "line" => 6, "description" => "", "id" => "test-feature;an-outline;one",
    #                                          "rows" => [{"cells" => ["var_a", "var_b"], "line" => 7, "id" => "test-feature;an-outline;one;1"},
    #                                                     {"cells" => ["1", "a"], "line" => 8, "id" => "test-feature;an-outline;one;2"},
    #                                                     {"cells" => ["2", "b"], "line" => 9, "id" => "test-feature;an-outline;one;3"}]},
    #                                         {"keyword" => "Examples", "name" => "Two", "line" => 11, "description" => "", "id" => "test-feature;an-outline;two",
    #                                          "rows" => [{"cells" => ["var_a", "var_b"], "line" => 12, "id" => "test-feature;an-outline;two;1"},
    #                                                     {"cells" => ["1", "a"], "line" => 13, "id" => "test-feature;an-outline;two;2"},
    #                                                     {"cells" => ["2", "b"], "line" => 14, "id" => "test-feature;an-outline;two;3"}]}]},
    #                         {"examples" => [{"keyword" => "Examples", "name" => "One", "line" => 31, "description" => "This is example One.", "id" => "test-feature;an-outline-with-everything;one",
    #                                          "rows" => [{"cells" => ["var_a", "var_b"], "line" => 34, "id" => "test-feature;an-outline-with-everything;one;1"},
    #                                                     {"cells" => ["1", "a"], "line" => 35, "id" => "test-feature;an-outline-with-everything;one;2"},
    #                                                     {"cells" => ["2", "b"], "line" => 36, "id" => "test-feature;an-outline-with-everything;one;3"}]},
    #                                         {"keyword" => "Examples", "name" => "Two", "line" => 39, "description" => "", "tags" => [{"name" => "@example_tag", "line" => 38}], "id" => "test-feature;an-outline-with-everything;two",
    #                                          "rows" => [{"cells" => ["var_a", "var_b"], "line" => 40, "id" => "test-feature;an-outline-with-everything;two;1"},
    #                                                     {"cells" => ["1", "a"], "line" => 41, "id" => "test-feature;an-outline-with-everything;two;2"},
    #                                                     {"cells" => ["2", "b"], "line" => 42, "id" => "test-feature;an-outline-with-everything;two;3"}]}]}])
    # end
    #
    # it 'should return scenario outlines name and line numbers as a map' do
    #   gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scen_outlines/basic")
    #   result = gs.query do
    #     select name, source_line, raw_element, raw_element, raw_element, raw_element
    #     as 'source_line' => 'line'
    #     as 'raw_element' => 'id'
    #     as 'raw_element' => 'type'
    #     as 'raw_element' => 'steps'
    #     as 'raw_element' => 'step_lines'
    #
    #     transform 'raw_element' => lambda { |element| element['id'] }
    #     transform 'raw_element' => lambda { |element| element['type'] }
    #     transform 'raw_element' => lambda { |element| element['steps'] }
    #     transform 'raw_element' => lambda { |element| element['steps'].collect { |step| step['keyword'] + step['name'] } }
    #
    #
    #     from outlines
    #   end
    #
    #   expect(result).to eq([{'name' => "An Outline",
    #                          'line' => 3,
    #                          'id' => 'test-feature;an-outline',
    #                          'type' => 'scenario_outline',
    #                          "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 4}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 5}],
    #                          "step_lines" => ["Given something happend", "Then I expect something else"]}])
    # end

  end
end

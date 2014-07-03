require 'spec_helper'

describe "select" do
  describe 'from scenario_outlines' do

    it 'should return lines from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select line
        from scenario_outlines
      end

      expect(result).to eq([{"line" => 3}])
    end

    it 'should return names from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select name
        from scenario_outlines
      end

      expect(result).to eq([{"name" => "An Outline"}])
    end

    it 'should return types from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select type
        from scenario_outlines
      end

      expect(result).to eq([{"type" => "scenario_outline"}])
    end

    it 'should return step lines from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select step_lines
        from scenario_outlines
      end

      expect(result).to eq([{"step_lines" => ["Given something happend", "Then I expect something else"]}])
    end

    it 'should return ids from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select id
        from scenario_outlines
      end

      expect(result).to eq([{"id" => "test-feature;an-outline"}])
    end

    it 'should return steps from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")

      result = gs.query do
        select steps
        from scenario_outlines
      end

      expect(result).to eq([{"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 4}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 5}]}])
    end


    it 'should return multiple things from scenario outlines' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines")

      result = gs.query do
        select name, tags
        from scenario_outlines
      end

      expect(result).to eq([{"name" => "An Outline", "tags" => nil},
                            {"name" => "An Outline", "tags" => nil},
                            {"name" => "An Outline with everything", "tags" => [{"name" => "@outline_tag", "line" => 21}]}])
    end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines")

      result = gr.query do
        select name
        from scenario_outlines
      end

      expect(result).to eq([{"name" => "An Outline"},
                            {"name" => "An Outline"},
                            {"name" => "An Outline with everything"}])
    end

    it 'should return multiple scenario outlines as a list of maps' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines")

      result = gr.query do
        select name
        from scenario_outlines
      end

      expect(result).to eq([{"name" => "An Outline"},
                            {"name" => "An Outline"},
                            {"name" => "An Outline with everything"}])
    end

    it "should return the examples from scenario outlines" do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")
      result = gr.query do
        select examples
        from scenario_outlines
      end

      expect(result).to eq([{"examples" => [{"keyword" => "Examples", "name" => "", "line" => 6,
                                             "description" => "", "id" => "test-feature;an-outline;",
                                             "rows" => [{"cells" => ["var_a", "var_b"], "line" => 7, "id" => "test-feature;an-outline;;1"},
                                                        {"cells" => ["1", "a"], "line" => 8, "id" => "test-feature;an-outline;;2"},
                                                        {"cells" => ["2", "b"], "line" => 9, "id" => "test-feature;an-outline;;3"},
                                                        {"cells" => ["3", "c"], "line" => 10, "id" => "test-feature;an-outline;;4"},
                                                        {"cells" => ["4", "d"], "line" => 11, "id" => "test-feature;an-outline;;5"}]}]}])
    end

    it "should return multiple examples used for a single scenario outline" do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/multiple_examples")
      result = gr.query do
        select examples
        from scenario_outlines
      end

      expect(result).to eq([{"examples" => [{"keyword" => "Examples", "name" => "One", "line" => 6, "description" => "", "id" => "test-feature;an-outline;one",
                                             "rows" => [{"cells" => ["var_a", "var_b"], "line" => 7, "id" => "test-feature;an-outline;one;1"},
                                                        {"cells" => ["1", "a"], "line" => 8, "id" => "test-feature;an-outline;one;2"},
                                                        {"cells" => ["2", "b"], "line" => 9, "id" => "test-feature;an-outline;one;3"}]},
                                            {"keyword" => "Examples", "name" => "Two", "line" => 11, "description" => "", "id" => "test-feature;an-outline;two",
                                             "rows" => [{"cells" => ["var_a", "var_b"], "line" => 12, "id" => "test-feature;an-outline;two;1"},
                                                        {"cells" => ["1", "a"], "line" => 13, "id" => "test-feature;an-outline;two;2"},
                                                        {"cells" => ["2", "b"], "line" => 14, "id" => "test-feature;an-outline;two;3"}]}]},
                            {"examples" => [{"keyword" => "Examples", "name" => "One", "line" => 31, "description" => "This is example One.", "id" => "test-feature;an-outline-with-everything;one",
                                             "rows" => [{"cells" => ["var_a", "var_b"], "line" => 34, "id" => "test-feature;an-outline-with-everything;one;1"},
                                                        {"cells" => ["1", "a"], "line" => 35, "id" => "test-feature;an-outline-with-everything;one;2"},
                                                        {"cells" => ["2", "b"], "line" => 36, "id" => "test-feature;an-outline-with-everything;one;3"}]},
                                            {"keyword" => "Examples", "name" => "Two", "line" => 39, "description" => "", "tags" => [{"name" => "@example_tag", "line" => 38}], "id" => "test-feature;an-outline-with-everything;two",
                                             "rows" => [{"cells" => ["var_a", "var_b"], "line" => 40, "id" => "test-feature;an-outline-with-everything;two;1"},
                                                        {"cells" => ["1", "a"], "line" => 41, "id" => "test-feature;an-outline-with-everything;two;2"},
                                                        {"cells" => ["2", "b"], "line" => 42, "id" => "test-feature;an-outline-with-everything;two;3"}]}]}])
    end


    it "should return all, complete, everything from scenario_outlines" do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/multiple_examples")


      expected = [{"all" => {"keyword" => "Scenario Outline",
                             "name" => "An Outline",
                             "line" => 3,
                             "description" => "",
                             "id" => "test-feature;an-outline",
                             "type" => "scenario_outline",
                             "steps" => [{"keyword" => "Given ",
                                          "name" => "something happend",
                                          "line" => 4},
                                         {"keyword" => "Then ",
                                          "name" => "I expect something else",
                                          "line" => 5}],
                             "examples" => [{"keyword" => "Examples",
                                             "name" => "One",
                                             "line" => 6,
                                             "description" => "",
                                             "id" => "test-feature;an-outline;one",
                                             "rows" => [{"cells" => ["var_a", "var_b"],
                                                         "line" => 7,
                                                         "id" => "test-feature;an-outline;one;1"},
                                                        {"cells" => ["1", "a"],
                                                         "line" => 8,
                                                         "id" => "test-feature;an-outline;one;2"},
                                                        {"cells" => ["2", "b"],
                                                         "line" => 9,
                                                         "id" => "test-feature;an-outline;one;3"}]},
                                            {"keyword" => "Examples",
                                             "name" => "Two",
                                             "line" => 11,
                                             "description" => "",
                                             "id" => "test-feature;an-outline;two",
                                             "rows" => [{"cells" => ["var_a", "var_b"],
                                                         "line" => 12,
                                                         "id" => "test-feature;an-outline;two;1"},
                                                        {"cells" => ["1", "a"],
                                                         "line" => 13,
                                                         "id" => "test-feature;an-outline;two;2"},
                                                        {"cells" => ["2", "b"],
                                                         "line" => 14,
                                                         "id" => "test-feature;an-outline;two;3"}]}]}},
                  {"all" => {"keyword" => "Scenario Outline",
                             "name" => "An Outline with everything",
                             "line" => 22,
                             "description" => "\nOutline description.",
                             "tags" => [{"name" => "@outline_tag",
                                         "line" => 21}],
                             "id" => "test-feature;an-outline-with-everything",
                             "type" => "scenario_outline",
                             "steps" => [{"keyword" => "Given ",
                                          "name" => "something happend",
                                          "line" => 26,
                                          "rows" => [{"cells" => ["a", "a"],
                                                      "line" => 27},
                                                     {"cells" => ["s", "a"],
                                                      "line" => 28},
                                                     {"cells" => ["s", "s"],
                                                      "line" => 29}]},
                                         {"keyword" => "Then ",
                                          "name" => "I expect something else",
                                          "line" => 30}],
                             "examples" => [{"keyword" => "Examples",
                                             "name" => "One",
                                             "line" => 31,
                                             "description" => "This is example One.",
                                             "id" => "test-feature;an-outline-with-everything;one",
                                             "rows" => [{"cells" => ["var_a", "var_b"],
                                                         "line" => 34,
                                                         "id" => "test-feature;an-outline-with-everything;one;1"},
                                                        {"cells" => ["1", "a"],
                                                         "line" => 35,
                                                         "id" => "test-feature;an-outline-with-everything;one;2"},
                                                        {"cells" => ["2", "b"],
                                                         "line" => 36,
                                                         "id" => "test-feature;an-outline-with-everything;one;3"}]},
                                            {"keyword" => "Examples",
                                             "name" => "Two",
                                             "line" => 39,
                                             "description" => "",
                                             "tags" => [{"name" => "@example_tag",
                                                         "line" => 38}],
                                             "id" => "test-feature;an-outline-with-everything;two",
                                             "rows" => [{"cells" => ["var_a", "var_b"],
                                                         "line" => 40,
                                                         "id" => "test-feature;an-outline-with-everything;two;1"},
                                                        {"cells" => ["1", "a"],
                                                         "line" => 41,
                                                         "id" => "test-feature;an-outline-with-everything;two;2"},
                                                        {"cells" => ["2", "b"],
                                                         "line" => 42,
                                                         "id" => "test-feature;an-outline-with-everything;two;3"}]}]}}]

      result = gr.query do
        select all
        from scenario_outlines
      end
      expect(result).to eq(expected)

      result = gr.query do
        select complete
        from scenario_outlines
      end
      expect(result).to eq(expected)

      result = gr.query do
        select everything
        from scenario_outlines
      end
      expect(result).to eq(expected)
    end

    it 'should return scenario outlines name and line numbers as a map' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scen_outlines/basic")
      result = gs.query do
        select name, line, type, step_lines, id, steps
        from scenario_outlines
      end

      expect(result).to eq([{'name' => "An Outline",
                             'line' => 3,
                             'id' => 'test-feature;an-outline',
                             'type' => 'scenario_outline',
                             "steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 4}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 5}],
                             "step_lines" => ["Given something happend", "Then I expect something else"]}])
    end

  end
end

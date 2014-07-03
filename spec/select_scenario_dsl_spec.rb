require 'spec_helper'

describe "select" do
  describe 'from scenarios' do

    it 'should return lines from scenarios' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gr.query do
        select line
        from scenarios
      end

      expect(result).to eq([{"line" => 6}, {"line" => 11}, {"line" => 16}, {"line" => 21}])
    end

    it 'should return names from scenarios' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gr.query do
        select name
        from scenarios
      end

      expect(result).to eq([{"name" => "Testing the slurping"}, {"name" => "Testing again"},
                            {"name" => "Testing yet again"}, {"name" => "Testing yet again part 2"}])
    end

    it 'should return types from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select type
        from scenarios
      end

      expect(result).to eq([{"type" => "scenario"}, {"type" => "scenario"},
                            {"type" => "scenario"}, {"type" => "scenario"}])
    end

    it 'should return step lines from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select step_lines
        from scenarios
      end

      expect(result).to eq([{"step_lines" => ["Given something happend", "Then I expect something else"]},
                            {"step_lines" => ["Given something happend", "Then I expect something else"]},
                            {"step_lines" => ["Given something happend", "Then I expect something else"]},
                            {"step_lines" => ["Given something happend", "Then I expect something else"]}])
    end

    it 'should return ids from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select id
        from scenarios
      end

      expect(result).to eq([{"id" => "test3-feature;testing-the-slurping"},
                            {"id" => "test3-feature;testing-again"},
                            {"id" => "test3-feature;testing-yet-again"},
                            {"id" => "test3-feature;testing-yet-again-part-2"},])
    end

    it 'should return steps from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select steps
        from scenarios
      end

      expect(result).to eq([{"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 7}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 8}]},
                            {"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 12}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 13}]},
                            {"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 17}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 18}]},
                            {"steps" => [{"keyword" => "Given ", "name" => "something happend", "line" => 22}, {"keyword" => "Then ", "name" => "I expect something else", "line" => 23}]}])
    end

    it 'should return multiple things from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select name, tags
        from scenarios
      end

      expect(result).to eq([{"name" => "Testing the slurping", "tags" => [{"name" => "@one", "line" => 5}]},
                            {"name" => "Testing again", "tags" => [{"name" => "@two", "line" => 10}]},
                            {"name" => "Testing yet again", "tags" => [{"name" => "@one", "line" => 15}]},
                            {"name" => "Testing yet again part 2", "tags" => [{"name" => "@one", "line" => 20}, {"name" => "@two", "line" => 20}]}])
    end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

      result = gr.query do
        select name
        from scenarios
      end

      expect(result).to eq([{"name" => "Has a table"}, {"name" => "Testing the slurping 1"},
                            {"name" => "Testing the slurping not to be found"}, {"name" => "Testing the slurping 2"},
                            {"name" => "Testing the slurping 3"}, {"name" => "Testing again"},
                            {"name" => "Testing yet again"}, {"name" => "Testing yet again part 2"}])
    end

    it 'should get multiple scenarios as a list of maps' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gr.query do
        select line, name
        from scenarios
      end

      expect(result).to eq([{'line' => 6, 'name' => "Testing the slurping"}, {'line' => 11, 'name' => "Testing again"},
                            {'line' => 16, 'name' => "Testing yet again"}, {'line' => 21, 'name' => "Testing yet again part 2"}])
    end

    it "should should return all, complete, everything from scenarios" do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/table")

      expected = [{"all" => {"keyword" => "Scenario",
                             "name" => "Has a table",
                             "line" => 4,
                             "description" => "Scenario description.",
                             "tags" => [{"name" => "@scenario_tag",
                                         "line" => 3}],
                             "id" => "simple;has-a-table",
                             "type" => "scenario",
                             "steps" => [{"keyword" => "Given ",
                                          "name" => "Something",
                                          "line" => 7,
                                          "rows" => [{"cells" => ["a", "a"],
                                                      "line" => 8},
                                                     {"cells" => ["s", "a"],
                                                      "line" => 9},
                                                     {"cells" => ["s", "s"],
                                                      "line" => 10}]},
                                         {"keyword" => "Then ",
                                          "name" => "something else",
                                          "line" => 11}]}}]

      result = gr.query do
        select all
        from scenarios
      end
      expect(result).to eq(expected)

      result = gr.query do
        select complete
        from scenarios
      end
      expect(result).to eq(expected)

      result = gr.query do
        select everything
        from scenarios
      end
      expect(result).to eq(expected)
    end

  end
end

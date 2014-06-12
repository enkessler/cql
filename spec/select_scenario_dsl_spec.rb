require 'spec_helper'

describe "select" do

  describe "single value, multiple results" do
    it 'should get scenario line number' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gr.query do
        select line
        from scenarios
      end

      expect(result).to eq([{"line" => 6}, {"line" => 11}, {"line" => 16}, {"line" => 21}])
    end

    it 'should get scenario name' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gr.query do
        select name
        from scenarios
      end

      expect(result).to eq([{"name" => "Testing the slurping"}, {"name" => "Testing again"},
                            {"name" => "Testing yet again"}, {"name" => "Testing yet again part 2"}])
    end

    it 'should get scenario name from multiple feature files' do
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
  end

  describe "multiple values" do
    it 'should get multiple scenarios as a list of maps' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gr.query do
        select line, name
        from scenarios
      end

      expect(result).to eq([{'line' => 6, 'name' => "Testing the slurping"}, {'line' => 11, 'name' => "Testing again"},
                            {'line' => 16, 'name' => "Testing yet again"}, {'line' => 21, 'name' => "Testing yet again part 2"}])
    end

    it "should select all" do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/table")
      expected = [{"all" => {"keyword" => "Scenario", "name" => "Has a table", "line" => 3,
                             "description" => "", "id" => "simple;has-a-table", "type" => "scenario",
                             "steps" => [{"keyword" => "Given ", "name" => "Something", "line" => 4,
                                          "rows" => [{"cells" => ["a", "a"], "line" => 5}, {"cells" => ["s", "a"], "line" => 6},
                                                     {"cells" => ["s", "s"], "line" => 7}]},
                                         {"keyword" => "Then ", "name" => "something else", "line" => 8}]}}]

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
    end

  end
end

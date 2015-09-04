require 'spec_helper'

describe "select" do
  describe 'from scenarios' do

    it 'should return tags from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/tags2")

      result = gs.query do
        select tags
        from scenarios
      end

      expect(result).to match_array([{"tags" => ["@two"]},
                                     {"tags" => ["@one"]},
                                     {"tags" => []},
                                     {"tags" => ["@two"]},
                                     {"tags" => ["@one"]},
                                     {"tags" => ["@two", "@four"]},
                                     {"tags" => ["@one", "@five"]},
                                     {"tags" => []},
                                     {"tags" => ["@two"]},
                                     {"tags" => ["@one"]}])
    end

    it 'should return descriptions from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/table")

      result = gs.query do
        select description_text
        from scenarios
      end

      expect(result).to eq([{"description_text" => "Scenario description."}])
    end

    it 'should return lines from scenarios' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gr.query do
        select source_line
        from scenarios
      end

      expect(result).to eq([{"source_line" => 6}, {"source_line" => 11}, {"source_line" => 16}, {"source_line" => 21}])
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
        select raw_element
        as type
        transform 'raw_element' => lambda { |element| element['type'] }
        from scenarios
      end

      expect(result).to eq([{"type" => "scenario"}, {"type" => "scenario"},
                            {"type" => "scenario"}, {"type" => "scenario"}])
    end

    it 'should return step lines from scenarios' do
      gs = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")

      result = gs.query do
        select raw_element
        as step_lines
        transform 'raw_element' => lambda { |element| element['steps'].collect { |step| step['keyword'] + step['name'] } }
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
        select raw_element
        as id
        transform 'raw_element' => lambda { |element| element['id'] }
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
        select raw_element
        as steps
        transform 'raw_element' => lambda { |element| element['steps'] }
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

      expect(result).to eq([{"name" => "Testing the slurping", "tags" => ["@one"]},
                            {"name" => "Testing again", "tags" => ["@two"]},
                            {"name" => "Testing yet again", "tags" => ["@one"]},
                            {"name" => "Testing yet again part 2", "tags" => ["@one", "@two"]}])
    end

    it 'should return things from multiple feature files' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple")

      result = gr.query do
        select name
        from scenarios
      end

      expect(result).to match_array([{"name" => "Has a table"}, {"name" => "Testing the slurping 1"},
                                     {"name" => "Testing the slurping not to be found"}, {"name" => "Testing the slurping 2"},
                                     {"name" => "Testing the slurping 3"}, {"name" => "Testing again"},
                                     {"name" => "Testing yet again"}, {"name" => "Testing yet again part 2"}])
    end

    it 'should get multiple scenarios as a list of maps' do
      gr = CQL::Repository.new("#{@feature_fixtures_directory}/scenario/simple2")
      result = gr.query do
        select source_line, name
        from scenarios
      end

      expect(result).to eq([{'source_line' => 6, 'name' => "Testing the slurping"}, {'source_line' => 11, 'name' => "Testing again"},
                            {'source_line' => 16, 'name' => "Testing yet again"}, {'source_line' => 21, 'name' => "Testing yet again part 2"}])
    end

  end
end

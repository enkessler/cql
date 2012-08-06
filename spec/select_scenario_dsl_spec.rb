require 'rspec'
require File.dirname(__FILE__) + "/../lib/repo"

describe "select" do
  describe "single value, single results" do

  end

  describe "single value, multiple results" do
    it 'should get scenario line number' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple2"
      result = gr.query do
        select line
        from scenarios
      end
      result.should == [{"line"=> 6}, {"line"=> 11}, {"line"=> 16}, {"line"=> 21}]
    end

    it 'should get scenario name' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple2"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == [{"name"=> "Testing the slurping"}, {"name"=> "Testing again"},
                        {"name"=> "Testing yet again"}, {"name"=> "Testing yet again part 2"}]
    end

    it 'should get scenario name from multiple feature files' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple"
      result = gr.query do
        select name
        from scenarios
      end
      result.should == [{"name"=> "Has a table"}, {"name"=> "Testing the slurping 1"},
                        {"name"=> "Testing the slurping not to be found"}, {"name"=> "Testing the slurping 2"},
                        {"name"=> "Testing the slurping 3"}, {"name"=> "Testing again"},
                        {"name"=> "Testing yet again"}, {"name"=> "Testing yet again part 2"}]
    end
  end

  describe "select all" do

  end

  describe "multiple values" do
    it 'should get multiple scenarios as a list of maps' do
      gr = CQL::Repository.new File.expand_path(File.dirname(__FILE__)) + "/../fixtures/features/scenario/simple2"
      result = gr.query do
        select line, name
        from scenarios
      end
      result.should == [{'line'=>6, 'name'=>"Testing the slurping"}, {'line'=>11, 'name'=>"Testing again"},
                        {'line'=>16, 'name'=>"Testing yet again"}, {'line'=>21, 'name'=>"Testing yet again part 2"}]
    end
  end
end
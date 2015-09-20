require 'spec_helper'

describe 'CQL::Repository' do

  clazz = CQL::Repository

  it 'can be made from a file path' do
    expect { clazz.new(@feature_fixtures_directory) }.to_not raise_error
  end

  it 'can be made from a model' do
    some_model = CukeModeler::Scenario.new

    expect { clazz.new(some_model) }.to_not raise_error
  end

  it "complains if can't be made from what it was given" do
    expect { clazz.new(:some_other_thing) }.to raise_error(ArgumentError, "Don't know how to make a repository from a Symbol")
  end

end

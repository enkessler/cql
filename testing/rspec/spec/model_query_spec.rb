require "#{File.dirname(__FILE__)}/spec_helper"


describe 'a query enhanced model', :cuke_modeler_1x => true do

  let(:model) { CukeModeler::Model.new }


  it 'can be queried' do
    expect(model).to respond_to(:query)
  end

  it 'correctly queries itself' do
    model.parent_model = :foo

    result = model.query do
      select parent_model
      from models
    end

    expect(result).to eq([{'parent_model' => :foo}])
  end

  # Need to make sure that a common module is used instead of duplicating code so
  # that duplicate testing is not likewise needed.
  it 'uses the same DSL module as a regular repository' do
    skip

    # make sure it includes the module
  end

  it 'does not further modify any common code' do
    skip

    # make sure it doesn't override methods
  end

end

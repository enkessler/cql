require "#{File.dirname(__FILE__)}/spec_helper"


describe 'a query enhanced model' do

  let(:clazz) { CukeModeler::Model }
  let(:model) { clazz.new }


  describe 'common behavior' do

    it_should_behave_like 'a queriable object'

  end


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


  describe 'some white box testing for extra safety' do

    # Need to make sure that a common module is used instead of duplicating code so
    # that duplicate testing is not likewise needed.
    it 'uses the same DSL module as a regular repository' do
      expect(model).to be_a_kind_of(CQL::Queriable)
    end

    # Need to make sure that the needed #initialize patching does not break the normal
    # behavior of the class.
    it 'still initializes normally' do
      expect { clazz.new(:not_a_string) }.to raise_error(ArgumentError, 'Can only create models from Strings but was given a Symbol.')
    end

  end

end

require_relative '../../../environments/rspec_env'


shared_examples_for 'a queriable object' do

  # clazz and seed_arguments must be defined by the calling file

  let(:object) { (defined? seed_arguments) ? clazz.new(seed_arguments) : clazz.new }


  it 'has a query root' do
    expect(object).to respond_to(:query_root)
  end

  it 'can change its query root' do
    expect(object).to respond_to(:query_root=)

    object.query_root = :some_query_root
    expect(object.query_root).to eq(:some_query_root)
    object.query_root = :some_other_query_root
    expect(object.query_root).to eq(:some_other_query_root)
  end

  it 'can be queried' do
    expect(object).to respond_to(:query)
  end

  it 'complains if a query is attempted without a query root being set' do
    object.query_root = nil

    expect {

      object.query do
        select :model
        from :all
      end

    }.to raise_error(ArgumentError, 'Query cannot be run. No query root has been set.')
  end

  it 'starts with a query root' do
    expect(object.query_root).to_not be_nil
  end

end

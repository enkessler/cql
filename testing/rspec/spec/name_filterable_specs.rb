require_relative '../../../environments/rspec_env'


shared_examples_for 'a name filterable target set' do |target_type, test_data|

  describe 'name filters' do

    it 'should filter by exact name' do
      gs = CQL::Repository.new(test_data[:exact_name][:fixture_location])

      expected_results = test_data[:exact_name][:expected_results]

      expected_results.each do |matched_name, expected|
        result = gs.query do
          select name
          from target_type
          with name matched_name
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter by regexp' do
      gs = CQL::Repository.new(test_data[:regexp][:fixture_location])

      expected_results = test_data[:regexp][:expected_results]

      expected_results.each do |matched_name, expected|
        result = gs.query do
          select name
          from target_type
          with name matched_name
        end

        expect(result).to match_array(expected)
      end
    end

    it 'can only handle a string or regular expression' do
      gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

      expect { gs.query do
        select name
        from scenarios
        with name 7
      end }.to raise_error(ArgumentError, /^Can only match a String or Regexp. Got (?:Fixnum|Integer)\.$/)

    end

  end
end

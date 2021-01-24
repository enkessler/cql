require_relative '../../../environments/rspec_env'


shared_examples_for 'a line filterable target set' do |target_type, test_data|

  describe 'line match filters' do

    it 'should filter by exact line' do
      gs = CQL::Repository.new(test_data[:exact_line][:fixture_location])

      expected_results = test_data[:exact_line][:expected_results]

      expected_results.each do |matched_line, expected|
        result = gs.query do
          select name
          from target_type
          with line matched_line
        end

        expect(result).to eq(expected)
      end
    end

    it 'should filter by regexp' do
      gs = CQL::Repository.new(test_data[:regexp][:fixture_location])

      expected_results = test_data[:regexp][:expected_results]

      expected_results.each do |matched_line, expected|
        result = gs.query do
          select name
          from target_type
          with line matched_line
        end

        expect(result).to eq(expected)
      end
    end

    it 'can only handle a string or regular expression' do
      gs = CQL::Repository.new(CQL_FEATURE_FIXTURES_DIRECTORY)

      expect do
        gs.query do
          select name
          from scenarios
          with line 7
        end
      end.to raise_error(ArgumentError, /^Can only match a String or Regexp. Got (?:Fixnum|Integer)\.$/)
    end

  end
end

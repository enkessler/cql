require "#{File.dirname(__FILE__)}/spec_helper"


describe 'an object that uses the DSL' do


  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe 'invalid query structure' do

    it "will complain if no 'from' clause is specified" do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      expect {
        gs.query do
          select
          features
        end
      }.to raise_error(ArgumentError, "A query must specify a 'from' clause")
    end

    it "will complain if no 'select' clause is specified" do
      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      expect {
        gs.query do
          from features
        end
      }.to raise_error(ArgumentError, "A query must specify a 'select' clause")
    end

  end


  describe 'clause ordering' do

    it 'handles intermixed clauses' do
      # Clause ordering doesn't matter as long as any given type of clause is ordered correctly with respect to its multiple uses

      gs = CQL::Repository.new("#{CQL_FEATURE_FIXTURES_DIRECTORY}/scenario/simple")

      results = gs.query do
        with { |scenario| scenario.name =~ /slurping/ }
        as thing1
        transform :self => lambda { |thing1| 1 }
        select :self
        as thing2
        with scenarios => lambda { |scenario| scenario.name =~ /3/ }
        from scenarios
        select :self
        transform :self => lambda { |thing2| 2 }
        select name
      end

      expect(results.first).to eq('thing1' => 1, 'thing2' => 2, 'name' => 'Testing the slurping 3')
    end

  end

end

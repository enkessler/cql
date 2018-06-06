require "#{File.dirname(__FILE__)}/spec_helper"


describe "predefined 'with' filters" do

  let(:nodule) { CQL::Dsl }
  let(:dsl_enabled_object) { Object.new.extend(nodule) }


  describe 'count filters' do

    describe 'tag count' do

      describe 'equality' do

        it 'correctly filters features' do
          feature_1 = CukeModeler::Feature.new('@tag
                                                Feature: Feature with 1 tag')
          feature_2 = CukeModeler::Feature.new('@tag @tag
                                                Feature: Feature with 2 tags')
          feature_3 = CukeModeler::Feature.new('@tag @tag @tag
                                                Feature: Feature with 3 tags')
          gs = CQL::Repository.new(directory_with(feature_1, feature_2, feature_3))

          result = gs.query do
            select name
            from features
            with tc eq 2
          end

          expect(result).to eq([{'name' => 'Feature with 2 tags'}])
        end

        it 'correctly filters scenarios' do
          gherkin = 'Feature:

                       @tag
                       Scenario: Test with 1 tag

                       @tag @tag
                       Scenario: Test with 2 tags

                       @tag @tag @tag
                       Scenario: Test with 3 tags'
          gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

          result = gs.query do
            select name
            from scenarios
            with tc eq 2
          end

          expect(result).to eq([{'name' => 'Test with 2 tags'}])
        end

        it 'correctly filters outlines' do
          gherkin = 'Feature:

                       @tag
                       Scenario Outline: Test with 1 tag

                       @tag @tag
                       Scenario Outline: Test with 2 tags

                       @tag @tag @tag
                       Scenario Outline: Test with 3 tags'
          gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

          result = gs.query do
            select name
            from outlines
            with tc eq 2
          end

          expect(result).to eq([{'name' => 'Test with 2 tags'}])
        end

        it 'correctly filters examples' do
          gherkin = 'Feature:

                       Scenario Outline:
                         * a step

                       @tag
                       Examples: Example with 1 tag
                       @tag @tag
                       Examples: Example with 2 tags
                       @tag @tag @tag
                       Examples: Example with 3 tags'
          gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

          result = gs.query do
            select name
            from examples
            with tc eq 2
          end

          expect(result).to eq([{'name' => 'Example with 2 tags'}])
        end

      end

    end

    describe 'line count' do

      describe 'equality' do

        it 'correctly filters backgrounds' do
          feature_1 = CukeModeler::Feature.new('Feature:
                                                  Background: Background with 1 step
                                                    * a step')
          feature_2 = CukeModeler::Feature.new('Feature:
                                                  Background: Background with 2 steps
                                                    * a step
                                                    * a step')
          feature_3 = CukeModeler::Feature.new('Feature:
                                                  Background: Background with 3 steps
                                                    * a step
                                                    * a step
                                                    * a step')
          gs = CQL::Repository.new(directory_with(feature_1, feature_2, feature_3))

          result = gs.query do
            select name
            from backgrounds
            with lc eq 2
          end

          expect(result).to eq([{'name' => 'Background with 2 steps'}])
        end

        it 'correctly filters scenarios' do
          gherkin = 'Feature:
                       Scenario: Test with 1 step
                         * a step
                       Scenario: Test with 2 steps
                         * a step
                         * a step
                       Scenario: Test with 3 steps
                        * a step
                        * a step
                        * a step'
          gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

          result = gs.query do
            select name
            from scenarios
            with lc eq 2
          end

          expect(result).to eq([{'name' => 'Test with 2 steps'}])
        end

        it 'correctly filters outlines' do
          gherkin = 'Feature:
                       Scenario Outline: Test with 1 step
                         * a step
                       Scenario Outline: Test with 2 steps
                         * a step
                         * a step
                       Scenario Outline: Test with 3 steps
                         * a step
                         * a step
                         * a step'
          gs = CQL::Repository.new(CukeModeler::Feature.new(gherkin))

          result = gs.query do
            select name
            from outlines
            with lc eq 2
          end

          expect(result).to eq([{'name' => 'Test with 2 steps'}])
        end

      end

    end

    describe 'scenario count' do

      describe 'equality' do

        it 'correctly filters features' do
          feature_1 = CukeModeler::Feature.new('Feature: Feature with 1 scenario
                                                  Scenario:')
          feature_2 = CukeModeler::Feature.new('Feature: Feature with 2 scenarios
                                                  Scenario:
                                                  Scenario:')
          feature_3 = CukeModeler::Feature.new('Feature: Feature with 3 scenarios
                                                  Scenario:
                                                  Scenario:
                                                  Scenario:')
          gs = CQL::Repository.new(directory_with(feature_1, feature_2, feature_3))

          result = gs.query do
            select name
            from features
            with sc eq 2
          end

          expect(result).to eq([{'name' => 'Feature with 2 scenarios'}])
        end

      end

    end

    describe 'outline count' do

      describe 'equality' do

        it 'correctly filters features' do
          feature_1 = CukeModeler::Feature.new('Feature: Feature with 1 outline
                                                  Scenario Outline:')
          feature_2 = CukeModeler::Feature.new('Feature: Feature with 2 outlines
                                                  Scenario Outline:
                                                  Scenario Outline:')
          feature_3 = CukeModeler::Feature.new('Feature: Feature with 3 outlines
                                                  Scenario Outline:
                                                  Scenario Outline:
                                                  Scenario Outline:')
          gs = CQL::Repository.new(directory_with(feature_1, feature_2, feature_3))

          result = gs.query do
            select name
            from features
            with soc eq 2
          end

          expect(result).to eq([{'name' => 'Feature with 2 outlines'}])
        end

      end

    end

    describe 'scenario and outline count' do

      describe 'equality' do

        it 'correctly filters features' do
          feature_1 = CukeModeler::Feature.new('Feature: Feature with 1 test
                                                  Scenario:')
          feature_2 = CukeModeler::Feature.new('Feature: Feature with 2 tests
                                                  Scenario:
                                                  Scenario Outline:')
          feature_3 = CukeModeler::Feature.new('Feature: Feature with 3 tests
                                                  Scenario:
                                                  Scenario Outline:
                                                  Scenario:')
          gs = CQL::Repository.new(directory_with(feature_1, feature_2, feature_3))

          result = gs.query do
            select name
            from features
            with ssoc eq 2
          end

          expect(result).to eq([{'name' => 'Feature with 2 tests'}])
        end

      end

    end

  end

end

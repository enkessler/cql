Feature: Models can be queried directly

  Scenario: Querying a model
    Given the models provided by CukeModeler
    Then  all of them can be queried
      """
        model = <model_class>.new

        model.query do

          select
          from :all

        end
      """

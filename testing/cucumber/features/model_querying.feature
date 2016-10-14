Feature: Models can be queried directly

  Note: This feature is only available with newer versions of the 'cuke_modeler' library.

  @cuke_modeler_1x
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

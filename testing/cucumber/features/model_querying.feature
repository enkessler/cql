Feature: Model querying

  Instead of using a repository, an extension can be activated (`require 'cql/model_dsl'`) that allows queries to be
  performed directly against CukeModeler models.


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

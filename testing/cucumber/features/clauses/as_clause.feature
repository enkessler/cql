Feature: 'as' clause'

  The *as* clause allows you to change the keys under which the model attributes specified by the *select* clause will be gathered. Key renaming can be done as a list of new names that are applied in order or as a mapping of specific keys to their new names.

  Sample usage:
  ````
  cql_repo.query do
    select name
    as title
    from features
  end
  ````

  This will return a list of all of the feature names but under the key of 'title' instead of 'name'.

  This clause can be repeated multiple times. When using lists of names, the arguments for successive clauses are simply added to the previous arguments. When using mapped names, the mappings are likewise combined. If the same key is mapped more than once, the mappings are tracked separately such that they can be applied to different instances of attribute retrieval (see examples below).


  Background: A sample Cucumber suite
    Given a model for the following feature:
      """
      Feature: A test feature

        Scenario: Test 1
          * some steps

        @special_tag
        Scenario: Test 2
          * some other steps

        Scenario Outline: Test 3
          * some steps
        Examples: First examples
          | param |
          | value |
        Examples: Second examples
          | param |
          | value |
      """
    And a repository that contains that model


  Scenario: Using 'as' to change the name under which values are returned
    When the following query is executed:
      """
      select name
      as scenario_name
      from scenarios, outlines
      """
    Then the following values are returned:
      | scenario_name |
      | Test 1        |
      | Test 2        |
      | Test 3        |

  Scenario: Renaming multiple attributes
    When the following query is executed:
      """
      select name, source_line
      as scenario_name, scenario_line
      from scenarios, outlines
      """
    Then the following values are returned:
      | scenario_name | scenario_line |
      | Test 1        | 3             |
      | Test 2        | 7             |
      | Test 3        | 10            |

  Scenario: Selectively renaming attributes
    When the following query is executed:
      """
      select name, source_line
      as source_line => 'scenario_line'
      from scenarios, outlines
      """
    Then the following values are returned:
      | name   | scenario_line |
      | Test 1 | 3             |
      | Test 2 | 7             |
      | Test 3 | 10            |

  Scenario: Using the 'as' clause multiple times
    When the following query is executed:
      """
      select name, source_line
      as scenario_name
      as scenario_line
      from scenarios, outlines
      """
    Then the result is the same as the result of the following query:
      """
      select name, source_line
      as scenario_name, scenario_line
      from scenarios, outlines
      """
    When the following query is executed:
      """
      select name, source_line
      as name => 'scenario_name'
      as source_line => 'scenario_line'
      from scenarios, outlines
      """
    And the result is the same as the result of the following query:
      """
      select name, source_line
      as name => 'scenario_name',
         source_line => 'scenario_line'
      from scenarios, outlines
      """

  Scenario: Renaming duplicate attributes

  Sometimes you may want to select the same attribute multiple times but track it separately in the results. This can be done with both set renaming and selective renaming.

    When the following query is executed:
      """
      select name, source_line, name
      as 'name 1', scenario_line, 'name 2'
      from scenarios, outlines
      """
    Then the following values are returned:
      | name 1 | scenario_line | name 2 |
      | Test 1 | 3             | Test 1 |
      | Test 2 | 7             | Test 2 |
      | Test 3 | 10            | Test 3 |
    When the following query is executed:
      """
      select name, source_line, name
      as name => 'name 1'
      as name => 'name 2'
      from scenarios, outlines
      """
    Then the following values are returned:
      | name 1 | source_line | name 2 |
      | Test 1 | 3           | Test 1 |
      | Test 2 | 7           | Test 2 |
      | Test 3 | 10          | Test 3 |

Feature: 'as' clause'

  The *as* clause allows you to change the keys under which the model attributes specified by the *select* clause will be gathered.

    Sample usage:
      cql_repo.query do
        select name
        as title
        from features
      end

  This will return a list of all of the feature names but under the key of 'title' instead of 'name'.

  # todo - add good /multiple clause use description


  Background: A sample Cucumber suite
    Given a directory "test_directory"
    And a file "test_directory/test_file_1.feature":
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
    And a repository is made from "test_directory"


  Scenario: Using 'as' to change the name under which values are returned
    When the following query is executed:
      """
      select name
      as scenario_name
      from test_elements
      """
    Then the following values are returned:
      | scenario_name |
      | Test 1        |
      | Test 2        |
      | Test 3        |

  Scenario: Renaming multiple attributes
    When the following query is executed:
      """
      select name, tags
      as scenario_name, scenario_tags
      from test_elements
      """
    Then the following values are returned:
      | scenario_name | scenario_tags    |
      | Test 1        | []               |
      | Test 2        | ['@special_tag'] |
      | Test 3        | []               |

  Scenario: Selectively renaming attributes
    When the following query is executed:
      """
      select name, tags
      as tags => 'scenario_tags'
      from test_elements
      """
    Then the following values are returned:
      | name   | scenario_tags    |
      | Test 1 | []               |
      | Test 2 | ['@special_tag'] |
      | Test 3 | []               |

  Scenario: Using the 'as' clause multiple times
    When the following query is executed:
      """
      select name, tags
      as scenario_name
      as scenario_tags
      from test_elements
      """
    Then the result is the same as the result of the following query:
      """
      select name, tags
      as scenario_name, scenario_tags
      from test_elements
      """
    When the following query is executed:
      """
      select name, tags
      as name => 'scenario_name'
      as tags => 'scenario_tags'
      from test_elements
      """
    And the result is the same as the result of the following query:
      """
      select name, tags
      as name => 'scenario_name',
         tags => 'scenario_tags'
      from test_elements
      """

  Scenario: Renaming duplicate attributes

  Sometimes you may want to select the same attribute multiple times but track it separately in the results. This can be done with both set renaming and selective renaming.

    When the following query is executed:
      """
      select name, tags, name
      as 'name 1', scenario_tags, 'name 2'
      from test_elements
      """
    Then the following values are returned:
      | name 1 | scenario_tags    | name 2 |
      | Test 1 | []               | Test 1 |
      | Test 2 | ['@special_tag'] | Test 2 |
      | Test 3 | []               | Test 3 |
    When the following query is executed:
      """
      select name, tags, name
      as name => 'name 1'
      as name => 'name 2'
      from test_elements
      """
    Then the following values are returned:
      | name 1 | tags             | name 2 |
      | Test 1 | []               | Test 1 |
      | Test 2 | ['@special_tag'] | Test 2 |
      | Test 3 | []               | Test 3 |

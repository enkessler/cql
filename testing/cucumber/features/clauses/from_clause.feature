Feature: 'from' clause

  The *from* clause specifies what type of models from which the *select* clause will gather its values. The *from* clause can take class objects defined in CukeModeler as well as shorthand versions thereof. The clause can also be given a special identifier in order to gather values from all models instead of specific model types.

  The following are some example values:

  ````
  CukeModeler::Outline  # exact class
  outline               # singular
  outlines              # pluralized
  ````

  Sample usage:
  ````
  cql_repo.query do
    select name
    from scenarios
  end
  ````

  This clause can be repeated multiple times. The arguments for successive clauses are simply added to the previous arguments.


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


  Scenario: Using 'from' to specify what kind of objects from which to return attributes
    When the following query is executed:
      """
      select name
      from scenarios
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 2 |
    When the following query is executed:
      """
      select name
      from outlines
      """
    Then the following values are returned:
      | name   |
      | Test 3 |

  Scenario: Gathering from multiple sources
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 2 |
      | Test 3 |

  Scenario: Using the shorthand form of class names
    When the following query is executed:
      """
      select name
      from CukeModeler::Scenario
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from scenario
      """
    And the result is the same as the result of the following query:
      """
      select name
      from scenarios
      """

  Scenario: Using the 'from' clause multiple times

  Note: Selecting from different types of model should be done with care since problems can occur if the attributes specified by the 'select' clause do not exist on all of the models specified by the 'from' clause

    When the following query is executed:
      """
      select name
      from scenarios
      from outlines
      """
    And the result is the same as the result of the following query:
      """
      select name
      from scenarios, outlines
      """

  Scenario: Gathering from everything

  Note: Very few selections will be applicable for all models

    When the following query is executed:
      """
      select :model
      from :all
      """
    Then all models are queried from


# Commented out so that they aren't picked up by Relish
#  @wip
#  Scenario: Can 'from' from all type of model
#
#  @wip
#  Scenario: From-ing from a collection

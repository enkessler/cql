Feature: 'select' clause

  The *select* clause specifies what attributes will be retrieved from the models specified by the *from* clause.
  Multiple values can be given and they are delimited by a comma. The *select* clause can take any method to which
  the objects specified by *from* know how to respond. The clause can also be given a special identifier in order to
  return the underlying models themselves instead of their attributes. If no attributes are specified then the
  underlying model will be returned instead, just as if the special identifier had been used (it is simply an alternate
  syntax and may look nicer in some queries).

  Sample usage:
  ````
  cql_repo.query do
    select name, tags, description_text
    from features
  end
  ````

  This clause can be repeated multiple times. The arguments for successive clauses are simply added to the previous
  arguments.


  Background: Repository with models
    Given a repository to query
    And the following feature has been modeled in the repository:
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


  Scenario: Using 'select' to specify which attributes of an object to return
    When the following query is executed:
      """
      select name
      from scenarios
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 2 |

  Scenario: Selection of multiple attributes
    When the following query is executed:
      """
      select name, source_line
      from scenarios
      """
    Then the following values are returned:
      | name   | source_line |
      | Test 1 | 3           |
      | Test 2 | 7           |

  Scenario: Selection of the same attribute multiple times

  Note: Duplicate attribute selection should be combined with an 'as' clause in order to ensure that later attribute
  selections do not override earlier selections of the same attribute.

    When the following query is executed:
      """
      select name, name
      as name1, name2
      from scenarios
      """
    Then the following values are returned:
      | name1  | name2  |
      | Test 1 | Test 1 |
      | Test 2 | Test 2 |

  Scenario: Selection of the underlying models

  Note: There is no difference between the two different special identifiers. They are merely aliases for each other.

    When the following query is executed:
      """
      select :self
      from scenarios
      """
    Then the models for the following items are returned:
      | Test 1 |
      | Test 2 |
    And equivalent results are returned for the following query:
      """
      select :model
      from scenarios
      """

  Scenario: Using the 'select' clause multiple times
    When the following query is executed:
      """
      select name
      select source_line
      from scenarios
      """
    Then the result is the same as the result of the following query:
      """
      select name, source_line
      from scenarios
      """

  Scenario: Default selection
    When the following query is executed:
      """
      select
      from scenarios
      """
    Then the result is the same as the result of the following query:
      """
      select :self
      from scenarios
      """

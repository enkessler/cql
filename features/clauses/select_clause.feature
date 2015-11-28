Feature: 'select' clause

  The *select* clause specifies what attributes will be retrieved from the models specified by the *from* clause. Multiple values can be given and they are delimited by a comma. The *select* clause can take any method to which the objects specified by *from* know how to respond. The clause can also be given a special identifier in order to return the underlying models themselves instead of their attributes. If no attributes are specified then the underlying model will be returned instead, just as if the special identifier had been used (it is simply an alternate syntax and may look nicer in some queries).

    Sample usage:
      cql_repo.query do
        select name, tags, description_text
        from features
      end

  This clause can be repeated multiple times. The arguments for successive clauses are simply added to the previous arguments.


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
    When the following query is executed:
      """
      select name, name
      from scenarios
      """
    Then the following values are returned:
      | name   | name   |
      | Test 1 | Test 1 |
      | Test 2 | Test 2 |

  Scenario: Selection of the underlying models
    When the following query is executed:
      """
      select :self
      from scenarios
      """
    Then the models for the following items are returned:
      | Test 1 |
      | Test 2 |
    And the result is the same as the result of the following query:
      """
      select
      from scenarios
      """

  Scenario: Repetitive selection
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

# Commented out so that they aren't picked up by Relish
#  @wip
#  Scenario: Can select from all types of model

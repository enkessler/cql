Feature: DSL

  The cql gem uses a DSL to specify queries on a repository object that models a Cucumber test suite. The DSL can
  query for any attribute that is available on the underlying models that represent the test suite.


  Background: A sample Cucumber suite
    Given a directory "test_directory"
    And a file "test_directory/test_file_1.feature":
      """
      Feature: A test feature

        Scenario: Test 1
          * some steps

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


  Scenario: Use 'select' to specify which attributes of an object to return
    When the following query is executed:
      """
      select 'name'
      from CukeModeler::TestElement
      """
    Then the following values are returned":
      | name   |
      | Test 1 |
      | Test 2 |
      | Test 3 |

  Scenario: Selection of multiple traits
    When the following query is executed:
      """
      select 'name', 'source_line'
      from CukeModeler::Scenario
      """
    Then the following values are returned":
      | name   | source_line |
      | Test 1 | 3           |
      | Test 2 | 6           |

  Scenario: Use 'from' to specify what kind of objects from which to return attributes
    When the following query is executed:
      """
      select 'name'
      from CukeModeler::Scenario
      """
    Then the following values are returned":
      | name   |
      | Test 1 |
      | Test 2 |
    When the following query is executed:
      """
      select 'name'
      from CukeModeler::Outline
      """
    Then the following values are returned":
      | name   |
      | Test 3 |

  Scenario: Using shorthand version of a class
    When the following query is executed:
      """
      select 'path'
      from feature_files
      """
    Then the following values are returned":
      | path                                       |
      | path/to/test_directory/test_file_1.feature |
    When the following query is executed:
      """
      select 'path'
      from CukeModeler::FeatureFile
      """
    Then the following values are returned":
      | path                                       |
      | path/to/test_directory/test_file_1.feature |

  @wip
  Scenario: Use 'order_by' to sort the results

  @wip
  Scenario: Can select from all types of model

  @wip
  Scenario: Can 'from' from all type of model

  @wip
  Scenario: From-ing from a collection

  # 'and' is a keyword. Some other kind of repeater word would be needed
  @wip
  Scenario: 'And' can be used instead of repeating the previous keyword
    When the following query is executed:
      """
      select 'name'
      and    'source_line'
      from CukeModeler::Scenario
      and  CukeModeler::Outline
      """
    Then the following values are returned":
      | name   | source_line |
      | Test 1 | 3           |
      | Test 2 | 6           |
      | Test 3 | 9           |

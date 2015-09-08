Feature: DSL

  The cql gem uses a DSL to specify queries on a repository object that models a Cucumber test suite. The DSL can
  query for any attribute that is available on the underlying models that represent the test suite.


  [<instance of CukeModeler::Feature>,
  <instance of CukeModeler::Feature>,
  <instance of CukeModeler::Feature>]


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

  @wip
  Scenario: '' are optional for names of things


# Commented out so that they aren't picked up by Relish
#
#  @wip
#  Scenario: Use 'order_by' to sort the results
#
#  # 'and' is a keyword. Some other kind of repeater word would be needed
#  @wip
#  Scenario: 'And' can be used instead of repeating the previous keyword
#    When the following query is executed:
#      """
#      select 'name'
#      and    'source_line'
#      from CukeModeler::Scenario
#      and  CukeModeler::Outline
#      """
#    Then the following values are returned:
#      | name   | source_line |
#      | Test 1 | 3           |
#      | Test 2 | 6           |
#      | Test 3 | 9           |

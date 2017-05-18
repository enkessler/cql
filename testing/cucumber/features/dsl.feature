Feature: DSL

  The cql gem uses a DSL to specify queries on a repository object that holds the models which represent a Cucumber test suite. The DSL can query for any attribute that is available on the underlying models.

  Sample usage:
  ````
  cql_repo.query do
    select name, source_line
    from features
  end
  ````

  Query results are returned as a list of attribute mappings for all of the models found in the repository. The sample query above might return:

  ````
  [{'name' => 'Feature 1', 'source_line' => 1},
  {'name' => 'Feature 2', 'source_line' => 3},
  {'name' => 'Feature 3', 'source_line' => 10}]
  ````

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


  Scenario: Automatic string conversion

  Although most times it is unnecessary, using full strings in a query can remove syntactical ambiguity.

    When the following query is executed:
      """
      select name
      from scenarios
      """
    Then the result is the same as the result of the following query:
      """
      select 'name'
      from 'scenarios'
      """


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

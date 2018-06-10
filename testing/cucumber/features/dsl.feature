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

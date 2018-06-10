# todo - Rewrite the scenarios such that they use their own test specific feature files instead of setting up a large suite in the background
Feature: 'with' clause

  There are several predefined filters that can be used with the *with* clause. Like regular 'block style' conditions, they can be negated using *without*, used in a targeted fashion, etc.

  Sample usage:
  ````
  cql_repo.query do
  select name, tags, description_text
  from features
  with tc lt 3
  end
  ````

  The following filters are supported for models that have tags:

  * tags - Filters out models that do not have the exact set of tags provided.
  * tc   - (tag count) Filters out models based on the number of tags that they have.

  The following filters are supported for models that have names:

  * name - Filters out models whose name does not match the name provided. Can be a string or regular expression.

  The following filters are supported for models that have steps:

  * line - Filters out models whose steps do not include the provided step (keywords and blocks are ignored). Can be a string or regular expression.
  * lc   - (line count) Filters out models based on the number of steps that they have.

  The following filters are supported for feature models:

  * sc   - (scenario count) Filters out models based on the number of scenarios that they have.
  * soc  - (scenario outline count) Filters out models based on the number of outlines that they have.
  * ssoc - (scenario and scenario outline count) Filters out models based on the total number of scenarios and outlines that they have.

  For count based filters, the following operators are available:

  * lt   (Less than)
  * lte  (Less than or equals)
  * gt   (Greater than)
  * gte  (Greater than or equals)
  * eq   (Equals)


  Background: A sample Cucumber suite
    Given a repository to query
    And the following feature has been modeled in the repository:
      """
      Feature: A test feature

        @tag_1 @tag_2
        Scenario: Test 1
          * some steps

        @special_tag @tag_2
        Scenario: Test 2
          * some other steps
          * some other steps
          * some other steps

        @a @b @c
        Scenario Outline: Test 3
          * some steps
          * some more steps
          * some more steps
          * some more steps
        Examples: First examples
          | param |
          | value |
        Examples: Second examples
          | param |
          | value |

        Scenario: Test 4
      """
    And the following feature has been modeled in the repository:
      """
      Feature: A feature with lots of scenarios

        Scenario: 1
          * different steps
          * different steps

        Scenario: 2
          * different steps
          * different steps

        Scenario: 3
          * different steps
          * different steps
      """
    And the following feature has been modeled in the repository:
      """
      Feature: A feature with lots of outlines

        Scenario Outline: 1
          * different steps
          * different steps
        Examples:
          | param |
          | value |

        Scenario Outline: 2
          * different steps
          * different steps
        Examples:
          | param |
          | value |

        Scenario Outline: 3
          * different steps
          * different steps
        Examples:
          | param |
          | value |
      """
    And the following feature has been modeled in the repository:
      """
      Feature: A feature with a mix of tests

        Scenario: 4
          * different steps
          * different steps

        Scenario Outline: 4
          * different steps
          * different steps
        Examples:
          | param |
          | value |
      """


  Scenario: Filtering by tags
    When the following query is executed:
      """
      select name
      from scenarios
      with tags '@tag_1', '@tag_2'
      """
    Then the following values are returned:
      | name   |
      | Test 1 |

  Scenario: Filtering by tag count
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with tc gt 2
      """
    Then the following values are returned:
      | name   |
      | Test 3 |

  Scenario: Filtering by name (exact match)
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with name 'Test 3'
      """
    Then the following values are returned:
      | name   |
      | Test 3 |

  Scenario: Filtering by name (regular expression)
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with name /Test [12]/
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 2 |

  Scenario: Filtering by line (exact match)
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with line 'some steps'
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 3 |

  Scenario: Filtering by line (regular expression)
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with line /other/
      """
    Then the following values are returned:
      | name   |
      | Test 2 |

  Scenario: Filtering by line count
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with lc gt 3
      """
    Then the following values are returned:
      | name   |
      | Test 3 |

  Scenario: Filtering by scenario count
    When the following query is executed:
      """
      select name
      from features
      with sc gt 2
      """
    Then the following values are returned:
      | name                             |
      | A test feature                   |
      | A feature with lots of scenarios |

  Scenario: Filtering by outline count
    When the following query is executed:
      """
      select name
      from features
      with soc gt 2
      """
    Then the following values are returned:
      | name                            |
      | A feature with lots of outlines |

  Scenario: Filtering by combined test count
    When the following query is executed:
      """
      select name
      from features
      with ssoc lt 3
      """
    Then the following values are returned:
      | name                          |
      | A feature with a mix of tests |

  Scenario: Using the 'lt' count filter
    When the following query is executed:
      """
      select name
      from features
      with ssoc lt 3
      """
    Then the following values are returned:
      | name                          |
      | A feature with a mix of tests |

  Scenario: Using the 'lte' count filter
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with lc lte 1
      """
    Then the following values are returned:
      | name   |
      | Test 1 |
      | Test 4 |

  Scenario: Using the 'gt' count filter
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with lc gt 3
      """
    Then the following values are returned:
      | name   |
      | Test 3 |

  Scenario: Using the 'gte' count filter
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with lc gte 3
      """
    Then the following values are returned:
      | name   |
      | Test 2 |
      | Test 3 |

  Scenario: Using the 'eq' count filter
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with tc eq 3
      """
    Then the following values are returned:
      | name   |
      | Test 3 |


  @wip
  Scenario: Using multiple filters

  @wip
  Scenario: Mixing targeted and blanket filters

  @wip
  Scenario: Selectively filtering models

  Scenario: Using 'without' for negation
    When the following query is executed:
      """
      select name
      from features
      without ssoc lt 3
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from features
      with ssoc gt 2
      """

  @wip
  Scenario: Mixing predefined filters and regular filters


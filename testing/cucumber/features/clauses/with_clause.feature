# todo - Rewrite the scenarios such that they use their own test specific feature files instead of setting up a large suite in the background
Feature: 'with' clause

  The *with* clause specifies filter conditions that will reduce the number of things targeted by the *from* clause. The *with* clause can take one or more blocks that will filter out any object for which the block does not evaluate to true (using 'without' instead of 'with' will have the opposite effect). Alternatively, mappings of specific *from* targets to their respective filtering blocks can be provided. The *with* clause can also take predefined filters (detailed below).

  Sample usage:
  ````
  cql_repo.query do
    select name, tags, description_text
    from features
    with { |feature| feature.name =~ /foo/ }
    with tc lt 3
  end
  ````

  This clause can be repeated multiple times. The arguments for successive clauses are simply added to the previous arguments.


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

        @a @b @c
        Scenario Outline: Test 3
          * some steps
          * some more steps
        Examples: First examples
          | param |
          | value |
        Examples: Second examples
          | param |
          | value |
      """
    And the following feature has been modeled in the repository:
      """
      Feature: A feature with lots of scenarios

        Scenario: 1
          * different steps

        Scenario: 2
          * different steps

        Scenario: 3
          * different steps
      """
    And the following feature has been modeled in the repository:
      """
      Feature: A feature with lots of outlines

        Scenario Outline: 1
          * different steps
        Examples:
          | param |
          | value |

        Scenario Outline: 2
          * different steps
        Examples:
          | param |
          | value |

        Scenario Outline: 3
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

        Scenario Outline: 4
          * different steps
        Examples:
          | param |
          | value |
      """


  Scenario: Using 'with' to limit the objects from which to return attributes
    When the following query is executed:
      """
      select name
      from scenarios
      with lambda { |scenario| scenario.source_line == 8 }
      """
    Then the following values are returned:
      | name   |
      | Test 2 |

  Scenario: Single filter shorthand
    When the following query is executed:
      """
      select name
      from scenarios
      with { |scenario| scenario.tags.include?('@special_tag') }
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from scenarios
      with lambda { |scenario| scenario.tags.include?('@special_tag') }
      """

  Scenario: Using multiple filters
    When the following query is executed:
      """
      select name
      from scenarios, outlines, examples
      with lambda { |element| element.is_a?(CukeModeler::Example) },
           lambda { |element| element.name =~ /Second/ }
      """
    Then the following values are returned:
      | name            |
      | Second examples |

  Scenario: Selectively filtering models
    When the following query is executed:
      """
      select name
      from features, scenarios
      with scenarios => tags('@tag_1','@tag_2')
      """
    Then the following values are returned:
      | name                             |
      | A test feature                   |
      | Test 1                           |
      | A feature with lots of scenarios |
      | A feature with lots of outlines  |
      | A feature with a mix of tests    |

  Scenario: Using the 'with' clause multiple times
    When the following query is executed:
      """
      select name
      from scenarios, outlines, examples
      with { |element| element.is_a?(CukeModeler::Example) }
      with { |element| element.name =~ /Second/ }
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from scenarios, outlines, examples
      with lambda { |element| element.is_a?(CukeModeler::Example) },
           lambda { |element| element.name =~ /Second/ }
      """
    When the following query is executed:
      """
      select name
      from features, scenarios
      with scenarios => lambda { |scenario| scenario.tags.include?('@tag_1') }
      with scenarios => lambda { |scenario| scenario.tags.include?('@tag_2') }
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from features, scenarios
      with({ scenarios => lambda { |scenario| scenario.tags.include?('@tag_1') }},
           { scenarios => lambda { |scenario| scenario.tags.include?('@tag_2') }})
      """

  Scenario: Mixing targeted and blanket filters
    When the following query is executed:
      """
      select name
      from examples, features
      with { |element| element.name != '' }
      with features => lambda { |feature| feature.name =~ /lots/ }
      """
    Then the following values are returned:
      | name                             |
      | First examples                   |
      | Second examples                  |
      | A feature with lots of scenarios |
      | A feature with lots of outlines  |

# todo - break out the predefined filters into another feature file?
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

  Scenario: Filtering by name
    When the following query is executed:
      """
      select name
      from scenarios, outlines
      with name 'Test 3'
      """
    Then the following values are returned:
      | name   |
      | Test 3 |
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

  Scenario: Filtering by line
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
      with lc gt 1
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

  @wip
  Scenario: Using the 'lt' count filter

  @wip
  Scenario: Using the 'lte' count filter

  @wip
  Scenario: Using the 'gt' count filter

  @wip
  Scenario: Using the 'gte' count filter

  Scenario: Using 'without' for negation
    When the following query is executed:
      """
      select name
      from scenarios
      without { |scenario| scenario.source_line == 8 }
      """
    Then the result is the same as the result of the following query:
      """
      select name
      from scenarios
      with { |scenario| !(scenario.source_line == 8) }
      """
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

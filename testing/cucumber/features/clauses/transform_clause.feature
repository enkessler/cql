Feature: 'transform' clause

  The *transform* clause allows you to change the values of the attributes specified by the *select* clause after they are gathered. Value transforming can be done as a list of transformation blocks that are applied in order or as a mapping of specific keys and their transformations.

  Sample usage:
  ````
  cql_repo.query do
    select name
    transform { |name| name.upcase }
    from features
  end
  ````

  This will return a list of all of the feature names but with all of their names upcased.

  This clause can be repeated multiple times. When using lists of transforms, the arguments for successive clauses are simply added to the previous arguments. When using mapped transforms, the mappings are likewise combined. If the same key is mapped more than once, the mappings are tracked separately such that they can be applied to different instances of attribute retrieval (see examples below).

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


  Scenario: Using 'transform' to change values after they are gathered
    When the following query is executed:
      """
      select name
      transform lambda { |name| name.upcase }
      from scenarios, outlines
      """
    Then the following values are returned:
      | name   |
      | TEST 1 |
      | TEST 2 |
      | TEST 3 |

  Scenario: Single transformation shorthand
    When the following query is executed:
      """
      select name
      transform { |name| name.upcase }
      from scenarios, outlines
      """
    Then the result is the same as the result of the following query:
      """
      select name
      transform lambda { |name| name.upcase }
      from scenarios, outlines
      """

  Scenario: Transformation of multiple values
    When the following query is executed:
      """
      select name, tags
      transform lambda{ |name| name.upcase },
                lambda{ |tags| 9 }
      from scenarios, outlines
      """
    Then the following values are returned:
      | name   | tags |
      | TEST 1 | 9    |
      | TEST 2 | 9    |
      | TEST 3 | 9    |

  Scenario: Selectively transforming attributes
    When the following query is executed:
      """
      select name, tags
      transform tags => lambda{ |tags| 9 }
      from scenarios, outlines
      """
    Then the following values are returned:
      | name   | tags |
      | Test 1 | 9    |
      | Test 2 | 9    |
      | Test 3 | 9    |

  Scenario: Using the 'transform' clause multiple times
    When the following query is executed:
      """
      select name, tags
      transform { |name| name.upcase }
      transform { |tags| 9 }
      from scenarios, outlines
      """
    Then the result is the same as the result of the following query:
      """
      select name, tags
      transform lambda { |name| name.upcase },
                lambda { |tags| 9 }
      from scenarios, outlines
      """
    When the following query is executed:
      """
      select name, tags
      transform name => lambda { |name| name.upcase }
      transform tags => lambda { |tags| 9 }
      from scenarios, outlines
      """
    Then the result is the same as the result of the following query:
      """
      select name, tags
      transform name => lambda { |name| name.upcase },
                tags => lambda { |tags| 9 }
      from scenarios, outlines
      """

  Scenario: Transforming duplicate attributes

  Reminder: Duplicate attribute selection should be used in conjunction with the 'as' clause.

  Sometimes you may want to select the same attribute multiple times and perform multiple different transformations on it. This can be done with both set transforming and selective transforming.

    When the following query is executed:
      """
      select name, tags, name
      as name1, tags, name2
      transform lambda { |name| name.upcase },
                lambda { |tags| 9 },
                lambda { |name| name.downcase }
      from scenarios, outlines
      """
    Then the following values are returned:
      | name1  | tags | name2  |
      | TEST 1 | 9    | test 1 |
      | TEST 2 | 9    | test 2 |
      | TEST 3 | 9    | test 3 |
    When the following query is executed:
      """
      select name, source_line, name
      as name1, source_line, name2
      transform name => lambda { |name| name.upcase }
      transform name => lambda { |name| name.downcase }
      from scenarios, outlines
      """
    Then the following values are returned:
      | name1  | source_line | name2  |
      | TEST 1 | 3           | test 1 |
      | TEST 2 | 7           | test 2 |
      | TEST 3 | 10          | test 3 |

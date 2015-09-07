Feature: Test Feature

  Scenario Outline: An Outline
    Given something happend
    Then I expect something else
  Examples: One
    | var_a | var_b |
    | 1     | a     |
    | 2     | b     |

  Examples: Two
    | var_a | var_b |
    | 1     | a     |
    | 2     | b     |


  Scenario: A Scenario
    Given something happend
    Then I expect something else

  @outline_tag
  Scenario Outline: An Outline with everything

  Outline description.

    Given something happend
      | a | a |
      | s | a |
      | s | s |
    Then I expect something else
  Examples: One
  This is example One.

    | var_a | var_b |
    | 1     | a     |
    | 2     | b     |

  @example_tag
  Examples: Two
    | var_a | var_b |
    | 1     | a     |
    | 2     | b     |


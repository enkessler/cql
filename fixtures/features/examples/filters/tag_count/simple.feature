Feature: Simple

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @one
    Examples: 1 tag
      | param |

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @one @two
    Examples: 2 tags
      | param |

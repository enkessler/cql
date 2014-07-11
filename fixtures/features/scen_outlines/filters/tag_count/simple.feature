Feature: Simple

  @one
  Scenario Outline: 1 tag
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

  @one @two
  Scenario Outline: 2 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

Feature: Simple2

  @one @two @three
  Scenario Outline: 3 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

  @one @two @three @four
  Scenario Outline: 4 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

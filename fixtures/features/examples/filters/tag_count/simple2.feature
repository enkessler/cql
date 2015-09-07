Feature: Simple2

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @one @two @three
    Examples: 3 tags
      | param |

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @one @two @three @four
    Examples: 4 tags
      | param |

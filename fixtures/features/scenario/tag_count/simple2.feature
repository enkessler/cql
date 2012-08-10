Feature: Simple

  @one @two @three
  Scenario: 3 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else

  @one @two @three @four
  Scenario: 4 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
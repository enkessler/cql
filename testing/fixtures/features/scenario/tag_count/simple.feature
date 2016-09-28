Feature: Simple

  @one
  Scenario: 1 tag
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else

  @one @two
  Scenario: 2 tags
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
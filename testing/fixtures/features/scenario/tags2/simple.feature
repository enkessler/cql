Feature: Simple

  @two
  Scenario: Has a table
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else

  @one
  Scenario: Next
    Given anything

  Scenario: Another
    Given a car

  @two
  Scenario: Blah
    Given lalala

  @one
  Scenario: Another
    Given a car
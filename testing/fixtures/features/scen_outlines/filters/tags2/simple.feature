Feature: Simple

  @two
  Scenario Outline: Has a table
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

  @one
  Scenario Outline: Next
    Given anything
  Examples:
    | param |

  Scenario Outline: Another
    Given a car
  Examples:
    | param |

  @two
  Scenario Outline: Blah
    Given lalala
  Examples:
    | param |

  @one
  Scenario Outline: Another
    Given a car
  Examples:
    | param |

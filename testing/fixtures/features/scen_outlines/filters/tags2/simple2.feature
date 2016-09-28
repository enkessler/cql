Feature: Simple 2

  @two @four
  Scenario Outline: Has a table hmmm
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  Examples:
    | param |

  @one @five
  Scenario Outline: Next
    Given anything
  Examples:
    | param |

  Scenario Outline: Another
    Given a car
  Examples:
    | param |

  @two
  Scenario Outline: Blah blah
    Given lalala
  Examples:
    | param |

  @one
  Scenario Outline: Another
    Given a car
  Examples:
    | param |

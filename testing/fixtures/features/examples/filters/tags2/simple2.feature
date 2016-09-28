Feature: Simple 2

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @two @four
  Examples: Has a table hmmm
    | param |

  Scenario Outline:
    Given anything
  @one @five
  Examples: Next
    | param |

  Scenario Outline:
    Given a car
  Examples: Another
    | param |

  Scenario Outline:
    Given lalala
  @two
  Examples: Blah blah
    | param |

  Scenario Outline:
    Given a car
  @one
  Examples: Another
    | param |

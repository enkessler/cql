Feature: Simple

  Scenario Outline:
    Given Something
      | a | a |
      | s | a |
      | s | s |
    Then something else
  @two
  Examples: Has a table
    | param |

  Scenario Outline:
    Given anything
  @one
  Examples: Next
    | param |

  Scenario Outline:
    Given a car
  Examples: Another
    | param |

  Scenario Outline:
    Given lalala
  @two
  Examples: Blah
    | param |

  Scenario Outline:
    Given a car
  @one
  Examples: Another
    | param |

Feature: f1_4_scenarios_5_so

  Scenario: A cat in a hat (4 scenarios, 5 scenario outlines)
    Given A cat in a hat
    And walked across the road
    Then he was on the other side

  Scenario: f1_scen2
    Given Something
    Then something else

  Scenario: f1_scen3
    Given Something
    Then something else

  Scenario: f1_scen4
    Given Something
    Then something else

  Scenario Outline: f1_so1
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f1_so2
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f1_so3
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f1_so4
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f1_so5
    Given blah <e>

  Examples:
    | e |
    | r |
Feature: f3_2_scenarios_3_so

  Scenario: f3_scen1
    Given Something
    Then something else

  Scenario: f3_scen2
    Given Something
    Then something else

  Scenario Outline: f3_so1
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f3_so2
    Given blah <e>

  Examples:
    | e |
    | r |

  Scenario Outline: f3_so3
    Given blah <e>

  Examples:
    | e |
    | r |
Feature: f1_4_scenarios_5_so
  (4 scenarios, 5 scenario outlines)

  Scenario: A cat in a hat
    Given A cat in a hat
    And walked across the road
    Then he was on the other side

  Scenario: The lonely giant
    Given he was very big
    And he was an orphan
    And no one wanted to play with him
    And he couldn't fit into normal sized building
    Then he was all alone

  Scenario: The king of kings
    Given king "George"
    And king "Bruce"
    Then George is the king of kings

  Scenario: A deer
    * A deer
    * A female deer
    * Ray, a drop of golden sun

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
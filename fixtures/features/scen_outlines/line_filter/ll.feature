Feature: Simple

  Scenario Outline: sc1
    Given all match
    Then green eggs and ham
  Examples:
    | param |

  Scenario Outline: sc2
    Given some other phrase
    Then all match
  Examples:
    | param |

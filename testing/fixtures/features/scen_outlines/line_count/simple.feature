Feature: Line Count

  Scenario Outline: 1 line
    Given Something
  Examples:
    | param |

  Scenario Outline: 2 lines
    Given Something
    Then something else
  Examples:
    | param |

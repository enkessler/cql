Feature: Line Count 2

  Scenario Outline: 3 lines
    Given Something
    Then something else
    Then something else
  Examples:
    | param |

  Scenario Outline: 4 lines
    Given Something
    Given Something
    Given Something
    Given Something
  Examples:
    | param |

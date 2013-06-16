Feature: Starks

  @Stark @Snow
  Scenario: Bastard Child
    Given "Ned Stark" has a mistress
    And they have a child
    Then the child will be called "Jon Snow"
    And he will join the "Night's Watch"

  @Stark @Baratheon
  Scenario: Hand of the king
    Given "Robert Baratheon" is king
    And "Ned Stark" is friends with "Robert Baratheon"
    Then "Ned Stark" will become "Hand of the King"
    And "Ned Stark" will have the following responsibilities
      | Ensuring Justice               |
      | Protecting the king            |
      | Finding out about conspiracies |

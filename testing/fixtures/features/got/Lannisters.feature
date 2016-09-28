Feature: Lannisters

  @Stark @Baratheon @Lannister
  Scenario: Strange relations
    Given "Cersai Lannister" is married to "King Robert Baratheon"
    And they have a child "Joffrey Baratheon"
    But "Jaime Lannister" is really the father
    Then the "Starks" will be in trouble

  @Lannister
  Scenario: Family Honour
    Given "Tywin Lannister" is ashamed of his dad
    And he wants the family name to continue
    And he craves power
    Then "Tywin Lannister" will build an army
    And become hand of the king

  @Targaryen @Lannister
  Scenario: Actually a good guy
    Given "Jamie Lannister" is in the "King's Guard"
    And the "Mad King" wants to burn the city
    Then "Jamie Lannister" will kill the "Mad King"
    And "King's Landing" will be saved
    And "Jamie Lannister" will become known as the "King Slayer"

Feature: Search
  In order to find information
  As a visitor/person
  I want to be able to search for an organization

  Background:
    Given there are organizations available

  Scenario: Searching for an organization name
    When I search for organization "Brewhouse"
    Then I should see search results for "Brewhouse"
    And I should see 1 result   

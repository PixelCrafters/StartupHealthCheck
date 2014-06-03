Feature: Search
  In order to find information
  As a visitor/person
  I want to be able to search for an organization

  Background:
    Given there are organizations available

  Scenario: Searching for an organization name
    When I search for "Brewhouse"
    Then I should see search results for "Brewhouse"
    And I should see 1 result(s)
    When I click on the first result for "Brewhouse"
    Then I should be on the profile page for "Brewhouse"   

  Scenario: Searching for a keyword
    When I search for "Web"
    Then I should see search results for "Web"
    And I should see 2 result(s)

  Scenario: Searching by organization type
    When I select the type "Startup"
    Then I should see search results for "Startup"
    And I should see 2 result(s)

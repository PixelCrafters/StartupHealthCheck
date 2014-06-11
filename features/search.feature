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

  @javascript
  Scenario: Searching by organization type
    Given a type named "Startups"
    When I select the type "Startups"
    Then I should see 1 result(s)

  @javascript @auth0
  Scenario: Searching by organization tag
    Given I can edit the profile
    When I add a new tag "software"
    And I search for "software"
    Then I should see 1 result(s)

  Scenario: Searching by user's name
    Given I login with "Twitter"
    When I search for "J C"
    Then I should see 1 result(s)

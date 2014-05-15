@auth0
Feature: Organization's tags
  In order to classify an organization
  As an organization admin
  I want to be able to tag my organization

  Background:
    Given an organization named "Brewhouse"

  @javascript
  Scenario: Adding a tag
    Given I am an admin user
    And I edit the tags
    And I add a new tag "software"
    Then the new tag "software" should be applied to my organization
    And I should see my organization when I browse by "software"

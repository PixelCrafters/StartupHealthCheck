@auth0
Feature: Organization's tags
  In order to classify an organization
  As an organization admin
  I want to be able to tag my organization

  Background:
    Given an organization named "Brewhouse"
    And I am an admin user
    And I edit the profile

  @javascript
  Scenario: Adding a tag
    When I add a new tag "software"
    Then the new tag "software" should be applied to my organization
    And I should see my organization when I browse by "software"

  @javascript
  Scenario: Removing a tag
    When I add a new tag "software"
    And I remove the tag
    Then I should not see the tag "software" on the organization profile 

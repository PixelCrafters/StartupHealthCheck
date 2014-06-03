@auth0 @javascript
Feature: Organization Types
  In order categorize organizations
  As an organization admin
  I want to be able to associated types with my organizations
  
  Background:
    Given an organization named "Brewhouse"
    And a type named "Startup"
    And I am an admin user

  Scenario: Adding a type
    When I edit the profile
    And I add a type "Startup"
    Then I should see the type "Startup" on my profile

  Scenario: Removing a type
    When I edit the profile
    And I add a type "Startup"
    And I remove the type
    Then I should not see the type "Startup" on my profile

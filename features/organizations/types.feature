@auth0 @javascript
Feature: Organization Types
  In order categorize organizations
  As an organization admin
  I want to be able to associated types with my organizations
  
  Background:
    Given an organization named "Brewhouse"
    Given a type named "Startup"

  Scenario: Adding a type
    Given I am an admin user
    When I edit the profile
    And I add a type
    Then I should see the type on my profile

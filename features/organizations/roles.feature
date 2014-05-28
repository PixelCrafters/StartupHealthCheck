@auth0 @javascript
Feature: Organization Roles
  In order associate myself with my organization
  As an organization admin
  I want to be able to add my role
  
  Background:
    Given an organization named "Brewhouse"
    Given a role named "Employee"

  Scenario: Organization Admin adds a role
    When I visit the profile page
    And I claim the profile
    And I login with "Twitter"
    And I submit an email address
    And I edit my profile page
    And I add my role "Employee"
    Then I should see my role "Employee"
    When I visit the profile page
    Then I should see my role "Employee"

  Scenario: Organization Admin removes a role
    When I visit the profile page
    And I claim the profile
    And I login with "Twitter"
    And I submit an email address
    And I edit my profile page
    And I add my role "Employee"
    And I remove my role "Employee"
    Then I should not see my role "Employee"

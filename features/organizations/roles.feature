@auth0 @javascript
Feature: Organization Roles
  In order associate myself with my organization
  As an organization admin
  I want to be able to add my role
  
  Background:
    Given an organization named "Brewhouse"
    Given a role named "Employee"

  Scenario: Organization Admin adds a role
    Given I am an admin user
    When I edit my profile page
    And I add my role "Employee"
    Then I should see my role "Employee"
    When I visit the profile page
    Then I should see my role "Employee"

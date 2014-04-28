Feature: Organization's profile
  In order to acquire info about an organization
  As a visitor/person
  I want to see an organization's profile

  Scenario: View public profile
    Given the organization has a profile page
    When I visit this page
    Then I should see the organizations profile

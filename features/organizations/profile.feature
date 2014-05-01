Feature: Organization's profile
  In order to acquire info about an organization
  As a visitor/person
  I want to see an organization's profile

  Background:
    Given an organization named "Brewhouse"

  Scenario: View public profile
    When I visit the profile page
    Then I should see the organization's profile

  Scenario: View organization's address
    When I visit the profile page
    Then I should see the organization's address

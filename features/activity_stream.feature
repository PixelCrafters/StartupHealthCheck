@auth0 @javascript
Feature: Activity Stream
  In order to have more exposure for my organization
  As an organization admin
  I want see my activity in the activity stream
  
  Background:
    Given an organization named "Brewhouse"

  Scenario: A new user registers
    Given I login with "Twitter"
    And I submit an email address
    When I go to the activity stream page
    Then I should see the "J C" activity

  Scenario: A user claims an organization profile
    Given I am an admin user
    When I go to the activity stream page
    Then I should see the claim activity

  Scenario: Org admin adding and removing tags
    Given I am an admin user
    And I edit the profile
    And I add a new tag "software"
    When I go to the activity stream page
    Then I should see the "added tag software" activity
    When I visit the profile page
    And I edit the profile
    And I remove the tag
    When I go to the activity stream page
    Then I should see the "removed tag software" activity

  Scenario: Org admin creating and deleting arbitrary links
    Given I am an admin user
    When I edit the profile
    And I add a profile link for "brewhouse.io" with name "Website"
    And I go to the activity stream page
    Then I should see the "added link Website" activity
    When I visit the profile page
    And I edit the profile
    And I delete the link
    When I go to the activity stream page
    Then I should see the "deleted link Website" activity

  Scenario: Org admin toggles the hiring checkbox
    Given I am an admin user
    When I edit the profile
    And I check the hiring box
    And I go to the activity stream page
    Then I should see the "Brewhouse is hiring" activity
    When I visit the profile page
    And I edit the profile
    And I uncheck the hiring box
    And I go to the activity stream page
    Then I should see the "Brewhouse is no longer hiring" activity

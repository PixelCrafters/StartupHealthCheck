@auth0
Feature: Activity Stream
  In order to have more exposure for my organization
  As an organization admin
  I want see my activity in the activity stream
  
  Background:
    Given an organization named "Brewhouse"

  @javascript
  Scenario: Org Admin doin' stuff and seeing it on the stream
    Given I am an admin user
    And I edit the profile
    And I add a new tag "software"
    When I go to the activity stream page
    Then I should see the "software" activity

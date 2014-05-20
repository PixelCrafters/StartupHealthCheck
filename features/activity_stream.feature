Feature: Activity Stream
  In order to have more exposure for my organization
  As an organization admin
  I want see my activity in the activity stream

  Scenario: Org Admin doin' stuff and seeing it on the stream
    Given I am an admin user
    And I add a new tag "software"
    When I go to the activity stream page
    Then I should see my activity

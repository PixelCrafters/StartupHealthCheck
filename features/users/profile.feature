@auth0 @javascript
Feature: User's profile
  In order to present information about myself
  As a user
  I want to have a profile page

  Background:
    Given I login with "Twitter"
    When I edit my profile page

  Scenario: Editing the profile page
    When I save my changes
    Then I should see my changes on my profile page

  Scenario: Unsubscribing from email digest
    When I unsubscribe from the email digest
    Then I should be unsubscribed

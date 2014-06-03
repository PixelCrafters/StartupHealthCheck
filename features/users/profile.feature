@auth0
Feature: User's profile
  In order to present information about myself
  As a user
  I want to have a profile page

  @javascript
  Scenario: Editing the profile page
    Given I login with "Twitter"
    When I edit my profile page
    And I save my changes
    Then I should see my changes on my profile page

Feature: User's profile
  In order to present information about myself
  As a user
  I want to have a profile page

  Scenario: Editing the profile page
    Given I login with "Twitter"
    Given I save my changes
    Then I should see my changes on my profile page

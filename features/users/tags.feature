@auth0 @javascript
Feature: User's tags
  In order to classify myself
  As a user
  I want to be able to tag myself

  Background:
    Given there is a user available
    And I visit the user profile page for "Example User"
    And I claim the user profile
    And I submit an email address
    And I edit the profile

  Scenario: Adding a tag
    When I add a new tag "developer"
    Then the new tag "developer" should be applied to my profile
    And I should see my name when I browse by "software"

  Scenario: Removing a tag
    When I add a new tag "developer"
    And I remove the tag
    Then I should not see the tag "developer" on my profile 

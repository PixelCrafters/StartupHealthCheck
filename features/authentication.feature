@javascript
Feature: Authentication
  In order to access my account
  As a person (user)
  I want to be able to register for an accout or sign in

  Scenario: Registering for an account
    And I click the login button
    And I select Twitter
    And Twitter authorizes me
    Then I should be logged in

  Scenario: Signing into my account
    Given I have registered
    And I click the login button
    And I select Twitter
    Then I should be logged in

Feature: My bootstrapped app kinda works
  In order to get going on coding my awesome app
  I want to have aruba and cucumber setup
  So I don't have to do it myself

  Scenario: App just runs
    When I get help for "slv"
    Then the exit status should be 0

  Scenario: The archive directory always exists in the home directory by default.
    When I successfully run `slv archive` 
    Then archive directory should exist in my home directory

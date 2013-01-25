Feature: SLV uses zip archives
  As a slv user
  I want to keep an archive of all passed issues.
  So I can easyly access issues.

  Scenario: Archive directory always exists in the home directory by default.
    Given the directory "slv" does not exists in the home directory
    When I successfully run `slv archive`
    Then "slv" directory should exist in my home directory

  Scenario: Adding a single issue to an archive
    Given issue "1" does not exists in archive "2010"
    When I successfully run `slv archive add 1 2010`
    And I successfully run `slv archive list 2010`
    Then the stdout should contain "+2010-001.pdf"

  Scenario: Adding range of issues to an archive
    Given issues "100"-"101" for archive "2010" does not exist in the default archive directory
    When I successfully run `slv archive add 100-101 2010`
    And I successfully run ` slv archive list 2010`
    Then issues "100"-"101" for archive "2010" have prefix "+"

  Scenario: Removing a single issue from archive
    Given issue "1" does exists in archive "2010"
    When I successfully run `slv archive remove 1 2010`
    And I successfully run `slv archive list 2010`
    Then the stdout should contain "-2010-001.pdf"

  Scenario: Extracting a single issue from archive
    Given issue "1" does exists in archive "2010"
    When I successfully run `slv archive extract 1 2010`
    Then issue "1" from archive "2010" exists in the default archive directory

  Scenario: Listing an archive
    When I successfully run `slv archive list 2010`
    Then the list of archive "2010" should contain "172" issues
Feature: SLV can search issues
  As a slv user
  I want to search issues for phrases
  And keep loog of search results

  Scenario: Search for a simple expression from web
    Given issue "74" from archive "2012" doesn't exist in the default archive directory
    And issue "74" from archive "2012" doesn't exist in the zip archive
    When I successfully run `slv grep 74 2012 'број\s+74'`
    Then the stdout should contain page "1" in the results

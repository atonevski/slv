Feature: Zip archive
  As a user
  When I use slv I want the issue pdf documents
  To be placed in zip archives yaerly and when 
  I ask for an issue, I want for me to be transparent
  If the issue is in the archive, and/or in the arhive directory
  Unzipped or to be downloaded from the site. 
  I want time to be a factor and slv always to choose the fastest method. 

  Scenario: Create and Append new issue
    Given the archive "2012" doesn't exist in the default arhive directory
    When I run `slv archive -a 1 2012`
    Then the archive "2012" exists in the default archive directory
    And the issue "2012-001" exists in the archive "2012"

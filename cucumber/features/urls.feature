@urls
Feature: URLs

  Background:
    Given I have deleted any previous results
    And I have submitted a result for the url "http://www.bbc.co.uk"
    And I have submitted another result for the url "http://www.bbc.co.uk"
    And I have submitted another result for the url "http://www.itv.com"
    And I have submitted a result for the url "http://www.gov.uk"

  Scenario: GET /urls shows the unique URLs that have been tests
    When I make a GET request to "/urls"
    Then there should be 3 URLs
    And the 1st URL should be "http://www.bbc.co.uk"
    And the 2nd URL should be "http://www.itv.com"
    And the 3nd URL should be "http://www.gov.uk"
@results
Feature: Results

  Background:
    Given I have deleted any previous results

  Scenario: DELETE /results deletes all of the results
    Given I have sent 3 results to the beacon end-point
    And I make a DELETE request to "/results"
    Then the response code should be 204
    And there should be no results

  Scenario: GET /results returns a list of results
    Given I have sent 5 results to the beacon end-point
    When I make a GET request to "/results"
    Then the response code should be 200
    And I should see a list of 5 results

  Scenario: GET /results/latest return the latest result
    Given I have sent 5 results to the beacon end-point
    When I make a GET request to "/results/latest"
    Then the response code should be 200
    And I should see the most recent result

  Scenario: GET /results/latest return the latest result for a url with the `url` parameter
    Given I have submitted a result for the url "http://www.bbc.co.uk/news"
    And I have submitted another result for the url "http://www.bbc.co.uk/weather"
    When I make a GET request to "/results/latest?url=http://www.bbc.co.uk/news"
    Then the response code should be 200
    And I should a result for the url "http://www.bbc.co.uk/news"

  Scenario: GET /results returns a limited list of results with the `limit` parameter
    Given I have sent 5 results to the beacon end-point
    When I make a GET request to "/results?limit=3"
    Then the response code should be 200
    And I should see a list of 3 results

  Scenario: GET /results only returns results for a given url with the `url` parameter
    Given I have submitted a result for the url "http://www.bbc.co.uk/news"
    And I have submitted another result for the url "http://www.bbc.co.uk/weather"
    When I make a GET request to "/results?url=http://www.bbc.co.uk/weather"
    Then the response code should be 200
    And I should see only 1 result

  Scenario: GET /results/:id returns a single result
    Given I have sent 1 result to the beacon end-point
    And I make a GET request to the newly created result
    Then the response code should be 200
    And I should see the result

  Scenario: GET /results/:id with an ID that doesn't exist returns a 404
    When I make a GET request to "/results/123"
    Then the response code should be 404
    And the response body JSON should be
      """
        {
          "errors": [
            {
              "message": "Result with ID 123 could not be found"
            }
          ]
        }
      """

  Scenario: DELETE /results/:id deletes a single result
    Given I have sent 1 result to the beacon end-point
    And I make a DELETE request to the newly created result
    Then the response code should be 204
    And there should be no results

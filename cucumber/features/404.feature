@404
Feature: 404

  Scenario: Undefined routes return a JSON formatted 404 message
    When I make a GET request to "/blablabla"
    Then the response code should be 404
    And the response body JSON should be
      """
        {
          "error": {
            "message": "Resource not found: /blablabla"
          }
        }
      """
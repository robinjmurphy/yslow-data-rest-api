@beacon
Feature: Beacon

  Scenario: POST /beacon accepts valid test result data
    When I make a POST request to "/beacon" with the following JSON
      """
        {
          "v": "3.1.8",
          "w": "538060",
          "o": "76",
          "u": "http%3A%2F%2Fwww.bbc.co.uk%2F",
          "r": "88",
          "i": "ydefault",
          "lt": "1883"
        }
      """
    Then the response code should be 201
    And the 'Location' header should point to the newly created result
    And I should see the result
require 'rest-client'

def test_data(url = "http://www.example.com")
  return {
    v: "3.1.8",
    w: 538060,
    o: 76,
    u: CGI.escape(url),
    r: 88,
    i: "ydefault",
    lt: 1883
  }
end

def send_beacon_request(test_data)
  @response = Server.post('/beacon', test_data.to_json)
  result = Server.get(@response.headers[:location])
  @id = JSON.parse(result.body)["results"][0]["id"]
end

Given(/^I have sent (\d+) results? to the beacon end\-point$/) do |number|
  number.to_i.times do
    send_beacon_request test_data
  end
end

Given(/^I have submitted (?:a|another) result for the url "(.*?)"$/) do |url|
  send_beacon_request test_data(url)
end

Then(/^the 'Location' header should point to the newly created result$/) do
  @response.headers[:location].should match /\/results\/[a-z0-9-]+$/
end
require 'rest-client'

When(/^I make a POST request to "(.*?)" with the following JSON$/) do |path, json|
  @response = Server.post(path, json)
end

Then(/^the response code should be (\d+)$/) do |code|
  @response.code.should == code.to_i
end

When(/^I make a GET request to "(.*?)"$/) do |path|
  @response = Server.get(path)
end

Given(/^I make a DELETE request to "(.*?)"$/) do |path|
  @response = Server.delete(path)
end

Then(/^the response body JSON should be$/) do |json|
  JSON.parse(@response).should == JSON.parse(json)
end
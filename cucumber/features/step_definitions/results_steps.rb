Given(/^I have deleted any previous results$/) do
  @response = Server.delete('/results')
  @response.code.should == 204
end

Then(/^I should see (?:a list of|only) (\d+) results?$/) do |length|
  JSON.parse(@response.body).length.should == length.to_i
end

Given(/^I make a GET request to the newly created result$/) do
  @response = Server.get(@response.headers[:location])
end

Then(/^I should see the result$/) do
  JSON.parse(@response.body)["id"].should_not == ''
end

Given(/^I make a DELETE request to the newly created result$/) do
  @response = Server.delete(@response.headers[:location])
end

Then(/^I should see the most recent result$/) do
  JSON.parse(@response.body)["id"].should == @id
end

Then(/^I should a result for the url "(.*?)"$/) do |url|
  JSON.parse(@response.body)["data"]["u"].should == url
end

Then(/^there should be no results$/) do
  @response = Server.get('/results')
  JSON.parse(@response.body).length.should == 0
end
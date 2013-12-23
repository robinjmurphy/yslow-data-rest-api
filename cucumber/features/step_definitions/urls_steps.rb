Then(/^there should be (\d+) URLs$/) do |count|
  JSON.parse(@response.body)["urls"].length.should == count.to_i
end

Then(/^the (\d)(?:nd|st|rd|th) URL should be "(.*?)"$/) do |position, url|
  JSON.parse(@response.body)["urls"][position.to_i - 1].should == url
end
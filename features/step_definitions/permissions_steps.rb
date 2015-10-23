Given(/^the developer "(.*?)" exists$/) do |dev_name|
  @developer = FactoryGirl::create :developer
  @developer.company_name = dev_name
  @developer.save
end

Given(/^the developer "(.*?)" sends me an approval request$/) do |dev_name|
  @developer = Developer.find_by(company_name: dev_name)
  @developer.request_approval_from @me
end

Given(/^I accept the approval request$/) do
  @me.approve_developer(@developer)
end

Then(/^I should see the first "(.*?)" have a "(.*?)" coloured background$/) do |css, colour|
  expect(first( :css, css)['class'].include? "disallowed").to be true
end

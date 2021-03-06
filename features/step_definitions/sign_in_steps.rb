Given(/^I am signed in as developer$/) do
  steps %(
    Given I am on the homepage
      And I click "Developers"
      Then I click the link "Sign up!"
    When I fill in the form with my "developer" details
      And I click "Sign up"
    Then I should see "You have signed up successfully."
  )
  @developer = Developer.last
end

Given(/^I am signed in as a user$/) do
  steps %(
    Given I am using a large screen
    And I am on the homepage
      And I click the link "User Log In"
      Then I click the link "Sign up!"
    When I fill in the form with my "user" details
      And I click "Sign up"
    Then I should see "Enter a name for the device"
  )
  @me = User.find_by(email: @me.email)
end

When(/^I fill in the form with my "(.*?)" details$/) do |actor|
  @me = FactoryGirl.build actor.to_sym
  find_by_id("#{actor}_password_confirmation")
  fill_in "#{actor}_email", with: @me.email
  fill_in "#{actor}_password", with: @me.password
  fill_in "#{actor}_password_confirmation", with: @me.password_confirmation
  if actor == 'developer'
    fill_in "#{actor}_company_name", with: @me.company_name
    fill_in "#{actor}_redirect_url", with: @me.redirect_url
  elsif actor == 'user'
    fill_in "#{actor}_username", with: @me.username
  end
end

When(/^I fill in an existing "(.*?)"'s email in the "(.*?)" field$/) do |actor, field|
  actor = FactoryGirl.create actor.to_sym
  fill_in field, with: actor.email
end

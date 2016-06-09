@javascript
Feature: Devices

  Background: There are some devices
    Given I am signed in as a user
      And I click the link "Devices"
      And there's a device in the database with the UUID "123456789123"
      And the device has checkins

    Scenario: User adds and views a device
      Given I click "add"
        And I enter UUID "123456789123" and a friendly name "G-RALA"
      When I click "Add"
      Then I should see "Right click on the map to checkin"
        And I click the link "Devices"
      Then I should see "Denham"
        When I click "Denham"
      When I click "Delete device"
      And I confirm "Delete device"
      Then I should see "Device deleted"
        And I should not have a device

    Scenario: User changes privacy settings on a device
      Given I click "add"
        When I enter UUID "123456789123" and a friendly name "G-RALA"
      And I click "Add"
      And I click the link "Devices"
      When I click the link "visibility"
        Then I should see "Location sharing is on"
        And I should have a published device
      When I click the link "cloud"
        Then I should see a link that says "cloud_done"
        And I should have a fogged device
      When I click the link "timer"
      And I click the slider
        Then I should have a delayed device

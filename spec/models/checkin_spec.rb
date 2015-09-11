require 'rails_helper'

RSpec.describe Checkin, type: :model do


  describe "realtionships" do

    it "should have a device" do
      checkin = FactoryGirl::create(:checkin)
      checkin.device = Device.create(imei: 1234)
      expect(checkin.device.imei).to eq "1234"
    end

  end
  
  describe "parsing" do

    it "should take a string with a GPS and return an object" do
      @checkin = Checkin.create_from_string(RequestFixture.w_gps)
      expect(@checkin.first.to_json).to eq Checkin.last.to_json
    end

  end

end
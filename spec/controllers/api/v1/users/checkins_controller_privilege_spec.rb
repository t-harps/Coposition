require 'rails_helper'

RSpec.describe Api::V1::CheckinsController, type: :controller do
  include ControllerMacros, CityMacros, CheckinsSpecHelpers

  let(:developer){FactoryGirl::create :developer}
  let(:user){FactoryGirl::create :user}
  let(:device){FactoryGirl::create :device, user_id: user.id, delayed: 10}
  let(:checkin){FactoryGirl::create :checkin, device_id: device.id}
  let(:historic_checkin) do
    ad = user.approval_for(developer).approval_date
    FactoryGirl::create :checkin, device_id: device.id, created_at: ad - 1.day
  end
  let(:params) {{ user_id: user.id, device_id: device.id }}

  before do
    request.headers["X-Api-Key"] = developer.api_key
    device
    Approval.link(user,developer,'Developer')
    Approval.accept(user,developer,'Developer')
  end

  context 'with 2 checkins: 1 old, 1 new' do
    before do
        historic_checkin
        checkin
    end

    describe "GET #last" do

      context "with privilege set to disallowed and bypass_delay set to false" do
        it "should return 0 checkins" do
          call_checkin_method('last', 0, false, 0, nil)
        end
      end

      context "with privilege set to disallowed and bypass_delay set to true" do
        it "should return 0 checkins" do
          call_checkin_method('last', 0, true, 0, nil)
        end
      end

      context "with privilege set to last_only and bypass_delay set to true" do
        it "should return 1 new checkin" do
          call_checkin_method('last', 1, true, 1, checkin)
        end
      end

      context "with privilege set to last_only and bypass_delay set to false" do
        it "should return 1 old checkin" do
          call_checkin_method('last', 1, false, 1, historic_checkin)
        end
      end

      context "with privilege set to complete and bypass_delay set to true" do
        it "should return 1 new checkin" do
          call_checkin_method('last', 2, true, 1, checkin)
        end
      end

      context "with privilege set to complete and bypass_delay set to false" do
        it "should return 1 old checkin" do
          call_checkin_method('last', 2, false, 1, historic_checkin)
        end
      end
    end

    describe "GET #index" do

      context "with privilege set to disallowed and bypass_delay set to false" do
        it "should return 0 checkins" do
          call_checkin_method('index', 0, false, 0, nil)
        end
      end

      context "with privilege set to disallowed and bypass_delay set to true" do
        it "should return 0 checkins" do
          call_checkin_method('index', 0, true, 0, nil)
        end
      end

      context "with privilege set to last_only and bypass_delay set to true" do
        it "should return 1 new checkin" do
          call_checkin_method('index', 1, true, 1, checkin)
        end
      end

      context "with privilege set to last_only and bypass_delay set to false" do
        it "should return 1 old checkin" do
          call_checkin_method('index', 1, false, 1, historic_checkin)
        end
      end

      context "with privilege set to complete and bypass_delay set to true" do
        it "should return 2 checkins" do
          call_checkin_method('index', 2, true, 2, checkin)
        end
      end

      context "with privilege set to complete and bypass_delay set to false" do
        it "should return 1 old checkin" do
          call_checkin_method('index', 2, false, 1, historic_checkin)
        end
      end
    end
  end

  context 'with 1 new checkin' do

    before do
      checkin
    end

    describe "GET #last" do

      context "with privilege set to disallowed and bypass_delay set to false" do
        it "should return 0 checkins" do
          call_checkin_method('last', 0, false, 0, nil)

        end
      end

      context "with privilege set to disallowed and bypass_delay set to true" do
        it "should return 0 checkins" do
          call_checkin_method('last', 0, true, 0, nil)
        end
      end

      context "with privilege set to last_only and bypass_delay set to true" do
        it "should return 1 new checkin" do
          call_checkin_method('last', 1, true, 1, checkin)
        end
      end

      context "with privilege set to last_only and bypass_delay set to false" do
        it "should return 0 checkins" do
          call_checkin_method('last', 1, false, 0, nil)
        end
      end

      context "with privilege set to complete and bypass_delay set to true" do
        it "should return 1 checkin" do
          call_checkin_method('last', 2, true, 1, checkin)
        end
      end

      context "with privilege set to complete and bypass_delay set to false" do
        it "should return 0 checkins" do
          call_checkin_method('last', 2, false, 0, nil)
        end
      end

    end

  end

end

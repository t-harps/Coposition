class Checkin < ActiveRecord::Base

  belongs_to :device

  [:new, :create].each do |prefix|
    define_singleton_method("#{prefix}_from_string") do |string|
      hash = to_hash(string)

      device = Device.where(imei: hash[:imei]).first
      device = Device.create(imei: hash[:imei]) unless device
      new_checkin = send(prefix, hash)
      device.checkins << new_checkin
      new_checkin
    end
  end

  def self.string_order
    [:imei,:enginespeed,:rotorspeed,:date,:time,:course,:altitude,
      :gspeed,:e_w,:lng,:n_s,:lat,:status]
  end

  protected

  def self.to_hash(string)
    string_order.zip(string.split(delimiter)).to_h
  end

  private

  def self.delimiter
    "|"
  end

end
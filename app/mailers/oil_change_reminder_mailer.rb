# frozen_string_literal: true

class OilChangeReminderMailer < ApplicationMailer
  # オイル交換リマインドメールを送信
  def reminder(user, vehicle)
    @user = user
    @vehicle = vehicle
    @km_until_next_oil_change = vehicle.km_until_next_oil_change
    @days_until_next_oil_change = vehicle.days_until_next_oil_change

    mail(
      to: @user.email,
      subject: "【MechaniCare】#{@vehicle.vehicle_name}のオイル交換時期が近づいています"
    )
  end
end

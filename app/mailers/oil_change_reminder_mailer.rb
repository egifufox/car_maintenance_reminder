# frozen_string_literal: true

class OilChangeReminderMailer < ApplicationMailer
  # オイル交換リマインドメールを送信
  def reminder(user, vehicle)
    @user = user
    @vehicle = vehicle

    # 走行距離ベースのフォーマット
    km_until = vehicle.km_until_next_oil_change
    @km_until_next_oil_change_text = if km_until < 0
                                        "#{km_until.abs}km超過"
                                      else
                                        "あと#{km_until} km"
                                      end

    # 期間ベースのフォーマット
    days_until = vehicle.days_until_next_oil_change
    @days_until_next_oil_change_text = if days_until < 0
                                          "#{days_until.abs}日超過"
                                        else
                                          "あと#{days_until}日"
                                        end

    mail(
      to: @user.email,
      subject: "【MechaniCare】#{@vehicle.vehicle_name}のオイル交換時期が近づいています"
    )
  end
end

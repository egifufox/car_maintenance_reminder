# frozen_string_literal: true

namespace :oil_change do
  desc 'オイル交換時期が近い車両のオーナーにメールを送信'
  task send_reminders: :environment do
    # オイル交換時期が近い車両を取得
    vehicles = Vehicle.includes(:user, :oil_change_records).select(&:needs_oil_change_soon?)

    vehicles.each do |vehicle|
      # メール送信
      OilChangeReminderMailer.reminder(vehicle.user, vehicle).deliver_now
      puts "メール送信: #{vehicle.user.email} (#{vehicle.vehicle_name})"
    end

    puts "送信完了: #{vehicles.count}件"
  end
end

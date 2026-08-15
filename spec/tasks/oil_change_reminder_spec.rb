# frozen_string_literal: true

require 'rails_helper'
require 'rake'

RSpec.describe 'oil_change:send_reminders', type: :task do
  before do
    Rake.application.rake_require 'tasks/oil_change_reminder'
    Rake::Task.define_task(:environment)

    # ✅ テスト前にデータをクリーンアップ
    OilChangeRecord.destroy_all
    Vehicle.destroy_all
    User.destroy_all
  end

  it 'メール送信が実行されること' do
    # テストデータを作成
    user = create(:user, email: 'test@example.com', name: 'テストユーザー')
    vehicle = create(:vehicle, user: user, vehicle_name: 'テスト車両')

    # オイル交換記録を作成(オイル交換時期が近い状態にする)
    create(:oil_change_record,
           vehicle: vehicle,
           mileage: vehicle.current_mileage - 4500, # 残り500kmでリマインダー
           changed_at: 6.months.ago)

    task = Rake::Task['oil_change:send_reminders']
    task.reenable

    # メール送信が1件実行されることを確認
    expect { task.invoke }.to change { ActionMailer::Base.deliveries.count }.by(1)
  end
end

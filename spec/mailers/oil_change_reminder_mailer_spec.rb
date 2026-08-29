# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OilChangeReminderMailer, type: :mailer do
  describe 'reminder' do
    let(:user) { create(:user, email: 'test@example.com', name: 'テストユーザー') }
    let(:vehicle) { create(:vehicle, user: user, vehicle_name: 'テスト車両') }
    let!(:oil_change_record) { create(:oil_change_record, vehicle: vehicle) }
    let(:mail) { OilChangeReminderMailer.reminder(user, vehicle) }

    it 'メールの宛先が正しいこと' do
      expect(mail.to).to eq(['test@example.com'])
    end

    it 'メールの件名が正しいこと' do
      expect(mail.subject).to eq('【MechaniCare】テスト車両のオイル交換時期が近づいています')
    end

    it 'メール本文にユーザー名が含まれていること' do
      # ✅ HTML部分を取得して検証
      expect(mail.html_part.body.to_s).to include(user.name)
    end

    it 'メール本文に車両名が含まれていること' do
      # ✅ HTML部分を取得して検証
      expect(mail.html_part.body.to_s).to include(vehicle.vehicle_name)
    end
  end
end

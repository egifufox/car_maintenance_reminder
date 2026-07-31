# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OilChangeRecord, type: :model do
  describe 'バリデーション' do
    it 'changed_at が必須であること' do
      record = build(:oil_change_record, changed_at: nil)
      expect(record).to be_invalid
      expect(record.errors[:changed_at]).to include('を入力してください')
    end

    it 'mileage が必須であること' do
      record = build(:oil_change_record, mileage: nil)
      expect(record).to be_invalid
      expect(record.errors[:mileage]).to include('を入力してください')
    end

    it 'mileage が 0 以上であること' do
      record = build(:oil_change_record, mileage: -1)
      expect(record).to be_invalid
      expect(record.errors[:mileage]).to include('は0以上の値にしてください')
    end
  end

  describe 'アソシエーション' do
    it 'vehicle に属すること' do
      association = described_class.reflect_on_association(:vehicle)
      expect(association.macro).to eq :belongs_to
    end
  end
end

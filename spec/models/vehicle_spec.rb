# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  describe 'バリデーション' do
    it 'vehicle_name が必須であること' do
      vehicle = build(:vehicle, vehicle_name: nil)
      expect(vehicle).to be_invalid
      expect(vehicle.errors[:vehicle_name]).to include('を入力してください')
    end

    it 'model が必須であること' do
      vehicle = build(:vehicle, model: nil)
      expect(vehicle).to be_invalid
      expect(vehicle.errors[:model]).to include('を入力してください')
    end

    it 'year が必須であること' do
      vehicle = build(:vehicle, year: nil)
      expect(vehicle).to be_invalid
      expect(vehicle.errors[:year]).to include('を入力してください')
    end

    it 'current_mileage が必須であること' do
      vehicle = build(:vehicle, current_mileage: nil)
      expect(vehicle).to be_invalid
      expect(vehicle.errors[:current_mileage]).to include('を入力してください')
    end

    it 'current_mileage が 0 以上であること' do
      vehicle = build(:vehicle, current_mileage: -1)
      expect(vehicle).to be_invalid
      expect(vehicle.errors[:current_mileage]).to include('は0以上の値にしてください')
    end
  end

  describe 'アソシエーション' do
    it 'user に属すること' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'manufacturer に属すること' do
      association = described_class.reflect_on_association(:manufacturer)
      expect(association.macro).to eq :belongs_to
    end

    it 'oil_change_records を持つこと' do
      association = described_class.reflect_on_association(:oil_change_records)
      expect(association.macro).to eq :has_many
    end

    it '車両が削除されたら、関連する oil_change_records も削除されること' do
      vehicle = create(:vehicle)
      create(:oil_change_record, vehicle: vehicle)
      expect { vehicle.destroy }.to change(OilChangeRecord, :count).by(-1)
    end
  end

  describe 'enum' do
    it 'vehicle_type が正しく定義されていること' do
      expect(Vehicle.vehicle_types).to eq({ 'normal' => 0, 'hybrid' => 1 })
    end
  end
end
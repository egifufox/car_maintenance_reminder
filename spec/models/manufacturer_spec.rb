# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Manufacturer, type: :model do
  describe 'バリデーション' do
    before do
      Manufacturer.destroy_all # ← テストの前にデータをクリア
    end

    it 'name が必須であること' do
      manufacturer = build(:manufacturer, name: nil)
      expect(manufacturer).to be_invalid
      expect(manufacturer.errors[:name]).to include('を入力してください')
    end

    it 'name が一意であること' do
      create(:manufacturer, name: 'トヨタ')
      manufacturer = build(:manufacturer, name: 'トヨタ')
      expect(manufacturer).to be_invalid
      expect(manufacturer.errors[:name]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーション' do
    it 'vehicles を持つこと' do
      association = described_class.reflect_on_association(:vehicles)
      expect(association.macro).to eq :has_many
    end

    it 'メーカーが削除されたら、関連する vehicles も削除されること' do
      manufacturer = create(:manufacturer)
      create(:vehicle, manufacturer: manufacturer)
      expect { manufacturer.destroy }.to change(Vehicle, :count).by(-1)
    end
  end
end

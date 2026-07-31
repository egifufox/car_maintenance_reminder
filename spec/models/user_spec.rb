# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it 'name が必須であること' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'name が 255 文字以内であること' do
      user = build(:user, name: 'a' * 256)
      expect(user).to be_invalid
      expect(user.errors[:name]).to include('は255文字以内で入力してください')
    end

    it 'email が必須であること' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('を入力してください')
    end

    it 'email が一意であること' do
      create(:user, email: 'test@example.com')
      user = build(:user, email: 'test@example.com')
      expect(user).to be_invalid
      expect(user.errors[:email]).to include('はすでに存在します')
    end
  end

  describe 'アソシエーション' do
    it 'vehicles を持つこと' do
      association = described_class.reflect_on_association(:vehicles)
      expect(association.macro).to eq :has_many
    end

    it 'ユーザーが削除されたら、関連する vehicles も削除されること' do
      user = create(:user)
      create(:vehicle, user: user)
      expect { user.destroy }.to change(Vehicle, :count).by(-1)
    end
  end

  describe '#own?' do
    let(:user) { create(:user) }
    let(:vehicle) { create(:vehicle, user: user) }

    it '自分の車両の場合、true を返すこと' do
      expect(user.own?(vehicle)).to be true
    end

    it '他人の車両の場合、false を返すこと' do
      other_user = create(:user)
      other_vehicle = create(:vehicle, user: other_user)
      expect(user.own?(other_vehicle)).to be false
    end
  end
end
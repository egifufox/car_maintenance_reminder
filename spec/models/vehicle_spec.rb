require 'rails_helper'

RSpec.describe Vehicle, type: :model do
  # 既存のテストはそのまま残す

  # 新しいテストを追加
  describe 'オイル交換関連のメソッド' do
    let(:vehicle) { create(:vehicle, current_mileage: 10000) }
    
    describe '#last_oil_change' do
      context 'オイル交換記録がある場合' do
        let!(:oil_change1) { create(:oil_change_record, vehicle: vehicle, changed_at: 2.months.ago, mileage: 8000) }
        let!(:oil_change2) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.month.ago, mileage: 9000) }
        
        it '最新のオイル交換記録を返すこと' do
          expect(vehicle.last_oil_change).to eq(oil_change2)
        end
      end
      
      context 'オイル交換記録がない場合' do
        it 'nilを返すこと' do
          expect(vehicle.last_oil_change).to be_nil
        end
      end
    end
    
    describe '#km_until_next_oil_change' do
      context 'オイル交換記録がある場合' do
        let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.month.ago, mileage: 8000) }
        
        it '次回交換までの走行距離を返すこと' do
          # 8000 + 5000 - 10000 = 3000
          expect(vehicle.km_until_next_oil_change).to eq(3000)
        end
        
        context '走行距離が超過している場合' do
          let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.year.ago, mileage: 4000) }
          
          it '負の値を返すこと' do
            # 4000 + 5000 - 10000 = -1000
            expect(vehicle.km_until_next_oil_change).to eq(-1000)
          end
        end
      end
      
      context 'オイル交換記録がない場合' do
        it 'nilを返すこと' do
          expect(vehicle.km_until_next_oil_change).to be_nil
        end
      end
    end
    
    describe '#days_until_next_oil_change' do
      context 'オイル交換記録がある場合' do
        let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.month.ago, mileage: 9000) }
        
        it '次回交換までの日数を返すこと' do
          # 365 - 30 = 335日
          expect(vehicle.days_until_next_oil_change).to be_within(1).of(335)
        end
        
        context '期間が超過している場合' do
          let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 2.years.ago, mileage: 9000) }
          
          it '負の値を返すこと' do
            # 365 - 730 = -365日
            expect(vehicle.days_until_next_oil_change).to be < 0
          end
        end
      end
      
      context 'オイル交換記録がない場合' do
        it 'nilを返すこと' do
          expect(vehicle.days_until_next_oil_change).to be_nil
        end
      end
    end
    
    describe '#needs_oil_change_soon?' do
      context 'オイル交換が必要な場合' do
        context '走行距離が1000km以内の場合' do
          let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.month.ago, mileage: 5500) }
          
          it 'trueを返すこと' do
            # 5000 - ( 10000 - 5500 ) = 500km
            expect(vehicle.needs_oil_change_soon?).to be true
          end
        end
        
        context '期間が30日以内の場合' do
          let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 12.months.ago + 10.days, mileage: 5000) }
          
          it 'trueを返すこと' do
            # 12ヶ月前 + 10日 + 12ヶ月 = 今日 + 10日 → 残り10日
            expect(vehicle.needs_oil_change_soon?).to be true
          end
        end
        
        context '走行距離も期間も超過している場合' do
          let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 2.years.ago, mileage: 4000) }
          
          it 'trueを返すこと' do
            expect(vehicle.needs_oil_change_soon?).to be true
          end
        end
      end
      
      context 'オイル交換が不要な場合' do
        let!(:oil_change) { create(:oil_change_record, vehicle: vehicle, changed_at: 1.week.ago, mileage: 9900) }
        
        it 'falseを返すこと' do
          # 9900 + 5000 - 10000 = 4900km
          # 365 - 7 = 358日
          expect(vehicle.needs_oil_change_soon?).to be false
        end
      end
      
      context 'オイル交換記録がない場合' do
        it 'falseを返すこと' do
          expect(vehicle.needs_oil_change_soon?).to be false
        end
      end
    end
  end
end
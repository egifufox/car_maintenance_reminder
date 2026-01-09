class Vehicle < ApplicationRecord
  # アソシエーション
  belongs_to :user
  belongs_to :manufacturer
  has_many :oil_change_records, dependent: :destroy

  # enum
  enum vehicle_type: { normal: 0, hybrid: 1 }

  # バリデーション
  validates :vehicle_name, presence: true
  validates :model, presence: true
  validates :year, presence: true, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 1900,
    less_than_or_equal_to: ->(record) { Date.current.year + 1 }
  }
  validates :vehicle_type, presence: true
  validates :current_mileage, presence: true, numericality: { 
    only_integer: true, 
    greater_than_or_equal_to: 0 
  }

  def last_oil_change
    oil_change_records.order(changed_at: :desc).first
  end

  def oil_change_interval_km
    hybrid? ? 10_000 : 5_000
  end

  # 次回交換まであと何km?
  def km_until_next_oil_change
    return nil if last_oil_change.blank?
    oil_change_interval_km - (current_mileage - last_oil_change.mileage)
  end

  # 次回交換まであと何日?
  def days_until_next_oil_change
    return nil if last_oil_change.blank?
    target_date = last_oil_change.changed_at + 1.year
    (target_date - Date.today).to_i
  end

  # 交換時期が近い?(警告表示が必要か判定)
  def needs_oil_change_soon?
    (km_until_next_oil_change.present? && km_until_next_oil_change <= 1000) ||
    (days_until_next_oil_change.present? && days_until_next_oil_change <= 30)
  end
end

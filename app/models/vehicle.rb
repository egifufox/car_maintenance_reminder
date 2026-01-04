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
end

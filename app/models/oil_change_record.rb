class OilChangeRecord < ApplicationRecord
  belongs_to :vehicle

  validates :changed_at, presence: true
  validates :mileage, presence: true, numericality: { only_integer: true, greater_than: 0 }
end

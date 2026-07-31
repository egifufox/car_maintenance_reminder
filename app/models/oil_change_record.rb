# frozen_string_literal: true

class OilChangeRecord < ApplicationRecord
  belongs_to :vehicle

  validates :changed_at, presence: true
  validates :mileage, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

# frozen_string_literal: true

class Manufacturer < ApplicationRecord
  has_many :vehicles, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end

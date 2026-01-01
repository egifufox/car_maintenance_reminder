class Manufacturer < ApplicationRecord
  has_many :vehicles, dependent: :destroy
end

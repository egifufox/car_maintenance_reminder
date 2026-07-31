# frozen_string_literal: true

FactoryBot.define do
  factory :oil_change_record do
    association :vehicle
    changed_at { 1.month.ago }
    mileage { 45_000 }
  end
end

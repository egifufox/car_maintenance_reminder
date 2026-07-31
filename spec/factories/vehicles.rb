# frozen_string_literal: true

FactoryBot.define do
  factory :vehicle do
    association :user
    association :manufacturer
    sequence(:vehicle_name) { |n| "マイカー#{n}" }
    sequence(:model) { |n| "カローラ#{n}" }
    year { 2020 }
    vehicle_type { :normal }
    current_mileage { 10_000 }

    # ハイブリッド車のファクトリ
    trait :hybrid do
      vehicle_type { :hybrid }
    end

    # オイル交換記録付きのファクトリ
    trait :with_oil_change_records do
      after(:create) do |vehicle|
        create_list(:oil_change_record, 3, vehicle: vehicle)
      end
    end
  end
end

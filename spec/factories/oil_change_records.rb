# frozen_string_literal: true

FactoryBot.define do
  factory :oil_change_record do
    association :vehicle
    changed_at { 6.months.ago }
    mileage { 5_000 }

    # 最近のオイル交換記録
    trait :recent do
      changed_at { 1.month.ago }
      mileage { 9_000 }
    end

    # 古いオイル交換記録
    trait :old do
      changed_at { 1.year.ago }
      mileage { 1_000 }
    end
  end
end

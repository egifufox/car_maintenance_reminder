# frozen_string_literal: true

FactoryBot.define do
  factory :manufacturer do
    sequence(:name) { |n| "メーカー#{n}" }
  end
end

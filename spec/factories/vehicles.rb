FactoryBot.define do
  factory :vehicle do
    association :user
    association :manufacturer
    vehicle_name { "マイカー" }
    model { "カローラ" }
    year { 2020 }
    vehicle_type { :normal }
    current_mileage { 0 }
  end
end
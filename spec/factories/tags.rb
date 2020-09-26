FactoryBot.define do
  factory :tag do
    name { Faker::Color.unique.color_name }
  end
end

FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    website { Faker::Internet.url }
    description { Faker::Markdown.sandwich(sentences: 5)}
    first_release { (1000..5000).to_a.sample.days.ago }
    last_release {  (500..1000).to_a.sample.days.ago }
    premium { [true, false].sample }
  end
end

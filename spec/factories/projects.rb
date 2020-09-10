FactoryBot.define do
  factory :project do
    name { "MyString" }
    website { "MyString" }
    description { "MyString" }
    first_release { "2020-09-10" }
    last_release { "MyString" }
    premium { false }
  end
end

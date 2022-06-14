# == Schema Information
#
# Table name: licenses
#
#  id         :bigint           not null, primary key
#  name       :string
#  key        :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :license do
    name { "MyString" }
    key { "MyString" }
    content { "MyText" }
  end
end

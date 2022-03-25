# == Schema Information
#
# Table name: submissions
#
#  id             :bigint           not null, primary key
#  name           :string
#  tagline        :string
#  description    :text
#  alternative_to :string
#  website        :string
#  suggested_tags :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :submission do
    name { "MyString" }
    tagline { "MyString" }
    description { "MyText" }
    alternative_to { "MyString" }
    website { "MyString" }
    suggested_tags { "MyString" }
  end
end

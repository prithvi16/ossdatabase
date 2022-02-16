# == Schema Information
#
# Table name: static_pages
#
#  id          :bigint           not null, primary key
#  key         :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  description :text             default(""), not null
#
FactoryBot.define do
  factory :static_page do
    key { "MyString" }
    content { "MyText" }
  end
end

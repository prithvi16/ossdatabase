# == Schema Information
#
# Table name: tags
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  tag_type     :string
#  top_category :boolean          default(FALSE), not null
#  slug         :string
#
FactoryBot.define do
  factory :tag do
    name { Faker::Color.unique.color_name }
  end
end

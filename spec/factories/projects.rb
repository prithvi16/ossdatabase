# == Schema Information
#
# Table name: projects
#
#  id                       :bigint           not null, primary key
#  name                     :string           not null
#  website                  :string           not null
#  description              :string           not null
#  first_release            :date
#  last_release             :date
#  premium                  :boolean
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  slug                     :string
#  visible                  :boolean          default(TRUE), not null
#  reviewed                 :boolean          default(FALSE), not null
#  tag_line                 :string           default(""), not null
#  source                   :string
#  source_id                :string
#  last_updated_from_source :datetime
#  repo_url                 :string
#
FactoryBot.define do
  factory :project do
    name { Faker::App.name }
    website { Faker::Internet.url }
    tag_line { Faker::Company.catch_phrase }
    description { Faker::Markdown.sandwich(sentences: 5) }
    first_release { (1000..5000).to_a.sample.days.ago }
    last_release { (500..1000).to_a.sample.days.ago }
    premium { [true, false].sample }
  end
end

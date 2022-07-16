# == Schema Information
#
# Table name: projects
#
#  id                                :bigint           not null, primary key
#  name                              :string           not null
#  website                           :string           not null
#  description                       :string           not null
#  first_release                     :date
#  last_release                      :date
#  premium                           :boolean
#  created_at                        :datetime         not null
#  updated_at                        :datetime         not null
#  slug                              :string
#  visible                           :boolean          default(TRUE), not null
#  reviewed                          :boolean          default(FALSE), not null
#  tag_line                          :string           default(""), not null
#  source                            :string
#  source_id                         :string
#  last_updated_from_source          :datetime
#  repo_url                          :string
#  proprietary                       :boolean          default(FALSE)
#  logo_url                          :string
#  github_stars                      :bigint
#  github_id                         :bigint
#  github_last_release_date          :datetime
#  github_last_commit_date           :datetime
#  github_open_issues_count          :bigint
#  github_forks_count                :integer
#  github_watchers_count             :integer
#  github_closed_issues_count        :integer
#  github_total_releases_count       :integer
#  github_open_pull_requests_count   :integer
#  github_closed_pull_requests_count :integer
#  github_commits_count_last_year    :integer
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

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
#  github_commits_count              :integer
#
class Project < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  has_one_attached :avatar

  validates_presence_of :name, :description, :website, :tag_line
  validates :website, format: {with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                               message: "invalid link format"}

  extend FriendlyId
  include PgSearch::Model
  include Searchable
  friendly_id :name, use: :slugged

  pg_search_scope :pg_search_by_name, against: {name: "A"},
    using: {tsearch: {dictionary: "english", prefix: true}}
  scope :filter_by_tag_ids, lambda { |tag_ids|
                              preload(:tags, :taggings).joins(:taggings).group(:id).having("array_agg(taggings.tag_id ORDER BY taggings.tag_id) @> ARRAY[?]::bigint[]", tag_ids.reject do |element|
                                                                                                                                                                          element.empty?
                                                                                                                                                                        end.sort)
                            }
  scope :filter_by_any_of_tag_ids, lambda { |tag_ids|
                                     preload(:tags, :taggings).joins(:taggings).group(:id).having("array_agg(taggings.tag_id ORDER BY taggings.tag_id) && ARRAY[?]::bigint[]", tag_ids.reject do |element|
                                                                                                                                                                                 element.empty?
                                                                                                                                                                               end.sort)
                                   }

  scope :filter_by_tag_type, lambda { |tag_type|
                               preload(:tags, :taggings).joins(:taggings).where(tags: {tag_type:})
                             }

  scope :without_tag_type, lambda { |tag_type|
                             where.not(id: Tagging.joins(:tag).where(tags: {tag_type:}).select(:project_id))
                           }

  def self.tagged_with(name)
    Tag.find_by!(name:).projects
  end

  def self.tag_counts
    Tag.select("tags.*, count(taggings.tag_id) as count").joins(:taggings).group("taggings.tag_id")
  end

  def invisible?
    !visible?
  end

  def tag_list
    tags.map(&:name).join(", ")
  end

  def any_tags_with?(tag_type)
    tags.where(tag_type:).any?
  end

  def self.tagged_with_top_categories
    Project.joins(:tags).where(tags: {top_category: true}).group("projects.id")
  end

  def self.search_suggestions(query)
    Project.pg_search_by_name(query).limit(5).select(:id, :name, :tag_line)
  end

  def tag_with(tag_name, tag_type)
    tag = Tag.where("name ilike ? and tag_type = ?", "%#{tag_name}%", tag_type).first
    tag = Tag.create(name: tag_name, tag_type:) unless tag&.persisted?
    puts tag.name
    tags << tag unless Tagging.where(project_id: id, tag_id: tag.id).any?
  end

  TOP_TAG_TYPES.each do |tag_type|
    define_method "#{tag_type}_tags" do
      tags.where(tag_type:)
    end
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end

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

  def self.search(params)
    tag_filters = []
    tag_list = %w[license_tag_ids tech_tag_ids usecase_tag_ids platform_tag_ids]
    tag_list.each do |tag_type|
      tag_filters += params[tag_type] if params[tag_type].present?
    end
    tag_filters = tag_filters.reject(&:empty?).uniq
    projects = Project.all
    if params[:pg_search_by_name].present?
      projects = projects.pg_search_by_name(params[:pg_search_by_name]).reorder(nil)
    end
    sidebar_tag_ids = JSON.parse(params[:sidebar_tag_ids]) if params[:sidebar_tag_ids].present?
    projects = projects.filter_by_any_of_tag_ids(sidebar_tag_ids) if !sidebar_tag_ids.nil? && sidebar_tag_ids.any?
    projects = projects.filter_by_tag_ids(tag_filters) if tag_filters.length >= 1
    if params[:proprietary].present? && ActiveRecord::Type::Boolean.new.cast(params[:proprietary])
      projects = projects.where(proprietary: false)
    end
    if !params.key?(:pg_search_by_name) && !params.key?(:sidebar_tag_ids) && !params.key?(:proprietary) && tag_filters.length == 0
      projects = projects.order("updated_at DESC")
    end
    projects.includes([:avatar_attachment]).page params[:page]
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

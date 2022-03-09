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
#  proprietary              :boolean          default(FALSE)
#  logo_url                 :string
#
class Project < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  has_one_attached :avatar
  
  validates_presence_of :name, :description, :website, :tag_line
  validates :website, format: {with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                               message: "invalid link format"}

  extend FriendlyId
  include Filterable
  include PgSearch::Model
  friendly_id :name, use: :slugged

  pg_search_scope :pg_search_by_name, against: :name, using: {tsearch: {dictionary: "english", prefix: true}}
  scope :filter_by_name, ->(name) { where("lower(projects.name) like ?", "%#{name.downcase}%") }
  scope :filter_by_tag_ids, ->(tag_ids) { joins(:taggings).group(:id).having("array_agg(taggings.tag_id ORDER BY taggings.tag_id) @> ARRAY[?]::bigint[]", tag_ids.reject { |element| element.empty? }.sort) }

  def self.tagged_with(name)
    Tag.find_by!(name: name).projects
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

  TOP_TAG_TYPES.each do |tag_type|
    define_method "#{tag_type}_tags" do
      self.tags.where(tag_type: tag_type)
    end
  end

  def self.ransackable_scopes(auth_object = nil)
    [:pg_search_by_name]
  end

  def tag_list=(names)
    self.tags = names.split(",").map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end

class Project < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name, :description, :website, :tag_line
  validates :website, format: { with: URI::regexp(%w(http https)),
    message: "invalid link format" }

  extend FriendlyId
  include Filterable
  friendly_id :name, use: :slugged

  scope :filter_by_name, -> (name) { where("projects.name like ?", "%#{name}%") }
  scope :filter_by_tag_ids, -> (tag_ids) { joins(:taggings).group(:id).having("array_agg(taggings.tag_id ORDER BY taggings.tag_id) @> ARRAY[?]::bigint[]", tag_ids.reject { |element| element.empty? }.sort) }

  def self.tagged_with(name)
    Tag.find_by!(name: name).projects
  end

  def self.tag_counts
    Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
  end

  def invisible?
    !self.visible?
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(names)
    self.tags = names.split(',').map do |n|
      Tag.where(name: n.strip).first_or_create!
    end
  end
end
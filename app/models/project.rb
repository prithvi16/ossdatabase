class Project < ApplicationRecord
  has_many :taggings
  has_many :tags, through: :taggings
  validates_presence_of :name, :description, :website
  validates :website, format: { with: URI::regexp(%w(http https)),
    message: "invalid link format" }

  extend FriendlyId
  friendly_id :name, use: :slugged

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

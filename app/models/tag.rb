class Tag < ApplicationRecord
  has_many :taggings
  has_many :projects, through: :taggings
  validates_uniqueness_of :name
  validates_presence_of :name
end

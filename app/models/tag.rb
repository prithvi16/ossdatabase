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
class Tag < ApplicationRecord
  has_many :taggings
  has_many :projects, through: :taggings
  validates_uniqueness_of :name, case_sensitive: false
  validates_presence_of :name

  extend FriendlyId
  friendly_id :name, use: :slugged
end

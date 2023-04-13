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
  validates_uniqueness_of :name, case_sensitive: false, scope: :tag_type
  validates_presence_of :name
  include PgSearch::Model

  extend FriendlyId
  friendly_id :name, use: :slugged

  pg_search_scope :pg_search_by_name, against: :name, using: {tsearch: {dictionary: "english", prefix: true}}

  def self.search_suggestions(query)
    pg_search_by_name(query).select(:name, :id).limit(3)
  end

  def license
    return unless tag_type == "license"

    License.find_by(key: name)
  end
end

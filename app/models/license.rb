# == Schema Information
#
# Table name: licenses
#
#  id         :bigint           not null, primary key
#  name       :string
#  key        :string
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#
class License < ApplicationRecord
  extend FriendlyId
  friendly_id :name_and_key, use: :slugged

  def name_and_key
    "#{name} #{key}"
  end

  def tag
    Tag.find_by(name: key)
  end

  def projects
    tag.projects
  end
end

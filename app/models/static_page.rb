# == Schema Information
#
# Table name: static_pages
#
#  id          :bigint           not null, primary key
#  key         :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  title       :string
#  description :text             default(""), not null
#
class StaticPage < ApplicationRecord
  validates_presence_of :title, :key, :description
end

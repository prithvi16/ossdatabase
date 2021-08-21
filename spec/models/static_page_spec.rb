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
require 'rails_helper'

RSpec.describe StaticPage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

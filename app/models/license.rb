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
#
class License < ApplicationRecord
end

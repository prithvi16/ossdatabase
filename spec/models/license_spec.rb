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
require 'rails_helper'

RSpec.describe License, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

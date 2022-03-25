# == Schema Information
#
# Table name: submissions
#
#  id             :bigint           not null, primary key
#  name           :string
#  tagline        :string
#  description    :text
#  alternative_to :string
#  website        :string
#  suggested_tags :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
require 'rails_helper'

RSpec.describe Submission, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

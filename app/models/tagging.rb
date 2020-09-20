class Tagging < ApplicationRecord
  belongs_to :tag
  belongs_to :project
  validates_uniqueness_of :tag_id, scope: :project_id
end

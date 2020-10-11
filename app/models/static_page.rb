class StaticPage < ApplicationRecord
  validates_presence_of :title, :key, :description
end

# frozen_string_literal: true

class TagListComponent < ViewComponent::Base
  def initialize(tag_list:)
    @tag_list = tag_list
  end
end

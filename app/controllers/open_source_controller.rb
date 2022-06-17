class OpenSourceController < ApplicationController
  def index
  end

  def license
  end

  def licenses_index
  end

  def license_picker
  end

  def alternatives
    @usecase_tags = Tag.where(tag_type: "usecase").order(:name)
  end
end

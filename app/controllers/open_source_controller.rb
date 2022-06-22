class OpenSourceController < ApplicationController
  def index
  end

  def license
  end

  def licenses_index
  end

  def licenses_list
    @licenses = License.all.select(:name, :key, :slug).order(:name)
  end

  def license_picker
  end

  def alternatives
    @usecase_tags = Tag.where(tag_type: "usecase").order(:name)
  end

  def alternative_usecase
    full_url = params[:id]
    usecase = full_url.gsub("open-source-", "").gsub("-software", "")
    @usecase_tag = Tag.friendly.find(usecase)
  end
end

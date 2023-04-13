class OpenSourceController < ApplicationController
  def index
  end

  def license
    @license = License.friendly.find(params[:id])
  end

  def licenses_index
  end

  def licenses_list
    @licenses = License.all.select(:name, :key, :slug).order(:name)
  end

  def license_picker
  end

  def projects_with_license
    @license = License.find_by(key: params[:key])
    @projects = @license.projects.includes(:taggings, :avatar_attachment, :tags).page params[:page]
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

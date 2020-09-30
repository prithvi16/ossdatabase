class ProjectListComponent < ViewComponent::Base
  def initialize(project_list:)
    @project_list = project_list
  end

  def first_release(project)
    if project.first_release.present?
      time_ago_in_words(project.first_release)
    else
      "--"
    end
  end
end

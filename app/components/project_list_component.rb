class ProjectListComponent < ViewComponent::Base
  def initialize(project_list:)
    @project_list = project_list
  end
end

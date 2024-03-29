class ProjectComponent < BaseComponent
  include ApplicationHelper

  def initialize(project:, current_user:)
    @project = project
    @current_user = current_user
  end

  def premium_description
    if @project.premium
      "YES"
    else
      "NO"
    end
  end

  def proprietary_description
    if @project.proprietary
      "YES"
    else
      "NO"
    end
  end

  def release_description
    if @project.first_release? && @project.last_release?
      @project.first_release.strftime("%B, %Y") + " - " + @project.last_release.strftime("%B, %Y")
    elsif @project.first_release?
      @project.first_release.strftime("%B, %Y") + " - -- "
    elsif @project.last_release?
      " - -- " + @project.last_release.strftime("%B, %Y")
    else
      "--"
    end
  end
end

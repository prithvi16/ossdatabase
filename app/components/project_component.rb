class ProjectComponent < ViewComponent::Base
  def initialize(project:, current_user:)
    @project = project
    @current_user = current_user
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true, link_attributes: { target: "_blank", rel: "noopener noreferrer nofollow" })
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

module ApplicationHelper
  def active_tab_class(path)
    active = false
    active ||= current_page?(path)
    active ? "border-b-2 border-indigo-500" : ""
  end
end

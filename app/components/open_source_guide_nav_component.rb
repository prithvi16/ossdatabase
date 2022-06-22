# frozen_string_literal: true

class OpenSourceGuideNavComponent < ViewComponent::Base
  def active_class(current_page)
    if request.path == current_page
      "bg-gray-300 text-gray-900"
    else
      "text-gray-600 hover:bg-gray-50 hover:text-gray-900"
    end
  end
end

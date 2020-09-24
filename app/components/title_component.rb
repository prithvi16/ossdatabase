class TitleComponent < ViewComponent::Base
  def initialize(page_title: "")
    @page_title = page_title
  end

  def local_title
    if @page_title.nil?
      nil
    else
      " | " + @page_title
    end
  end
end

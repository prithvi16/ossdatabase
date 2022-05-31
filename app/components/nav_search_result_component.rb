# frozen_string_literal: true

class NavSearchResultComponent < ViewComponent::Base
  def initialize(results:)
    @results = results
  end
end

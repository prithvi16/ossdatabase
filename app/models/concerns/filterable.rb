module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def filter(filtering_params)
      results = where(nil)
      if filtering_params.present?
        filtering_params.each do |key, value|
          results = results.merge(Project.public_send("filter_by_#{key}", value)) if is_present(value)
        end
      end
      results.includes(:tags)
    end

    def is_present(value)
      if value.instance_of?(String)
        if value.empty?
          false
        else
          true
        end
      elsif value.instance_of?(Array)
        if value.reject { |element| element.empty? }.empty?
          false
        else
          true
        end
      else
        false
      end
    end
  end
end

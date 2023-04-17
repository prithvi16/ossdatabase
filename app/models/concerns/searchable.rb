# app/models/concerns/searchable.rb
module Searchable
  extend ActiveSupport::Concern

  class_methods do
    def search(params)
      tag_filters = extract_tag_filters(params)
      projects = base_search_scope
      projects = apply_name_search(params, projects)
      projects = apply_sidebar_tags(params, projects)
      projects = apply_tag_filters(tag_filters, projects)
      projects = apply_open_source_filter(params, projects)
      projects = apply_default_ordering(params, tag_filters, projects)
      projects = Project.all if projects.blank?
      projects.includes([:avatar_attachment]).page params[:page]
    end

    private

    def extract_tag_filters(params)
      tag_filters = []
      tag_list = %w[license_tag_ids tech_tag_ids usecase_tag_ids platform_tag_ids]
      tag_list.each do |tag_type|
        tag_filters += params[tag_type.to_s] if params[tag_type.to_s].present?
      end
      tag_filters = tag_filters.reject(&:empty?).uniq
    end

    def base_search_scope
      Project.all
    end

    def apply_name_search(params, projects)
      return projects unless params[:pg_search_by_name].present?

      projects.pg_search_by_name(params[:pg_search_by_name]).reorder(nil)
    end

    def apply_sidebar_tags(params, projects)
      if params[:sidebar_tag_ids].present?
        sidebar_tag_ids = JSON.parse(params[:sidebar_tag_ids])
        projects.filter_by_any_of_tag_ids(sidebar_tag_ids) if sidebar_tag_ids.any?
      else
        projects
      end
    end

    def apply_tag_filters(tag_filters, projects)
      return projects if tag_filters.length < 1

      projects.filter_by_tag_ids(tag_filters)
    end

    def apply_open_source_filter(params, projects)
      return projects unless params[:open_source].present? && ActiveRecord::Type::Boolean.new.cast(params[:open_source])

      projects.where(proprietary: false)
    end

    def apply_default_ordering(params, tag_filters, projects)
      return projects.order("updated_at DESC") if no_search_params?(params, tag_filters)

      projects
    end

    def no_search_params?(params, tag_filters)
      !params.key?(:pg_search_by_name) && !params.key?(:sidebar_tag_ids) && !params.key?(:proprietary) && tag_filters.length == 0
    end
  end
end

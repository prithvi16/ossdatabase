class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Turbo::Redirection

  def set_tag_options
    @license_tag_options = Tag.where(tag_type: "license").map { |t| [t.name, t.id] }
    @tech_tag_options = Tag.where(tag_type: "tech").map { |t| [t.name, t.id] }
    @usecase_tag_options = Tag.where(tag_type: "usecase").map { |t| [t.name, t.id] }
    @platform_tag_options = Tag.where(tag_type: "platform").map { |t| [t.name, t.id] }
  end

  def track_search_query(params)
    if params.key?(:pg_search_by_name) && params[:pg_search_by_name].present?
      ahoy.track "search", query: params[:pg_search_by_name]
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end

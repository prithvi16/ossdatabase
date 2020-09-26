Rails.application.routes.draw do
  get 'projects/browse', to: "tags#index", as: "projects_browse"
  get 'tags/show'
  get 'projects/search', to: "projects#search", as: "projects_search"
  resources :projects, only: [:new, :show, :create, :edit, :update]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "pages#home"
end

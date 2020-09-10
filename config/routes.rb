Rails.application.routes.draw do
  get 'projects/search', to: "projects#search", as: "projects_search"
  resources :projects, only: [:index, :show, :create]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  root to: "pages#home"
end

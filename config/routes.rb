Rails.application.routes.draw do
  get 'projects/browse', to: "tags#index", as: "projects_browse"
  get 'projects/search', to: "projects#search", as: "projects_search"
  root to: "pages#home"

  get 'tags/:tag_name', to: "tags#show", as: "tag_show"
  resources :projects, only: [:new, :show, :create, :edit, :update]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'pages/:key', to: "pages#static", as: "static_page"
end

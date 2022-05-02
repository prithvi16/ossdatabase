require "sidekiq/web"

Rails.application.routes.draw do
  get "projects/browse", to: "tags#index", as: "projects_browse"
  get "projects/search", to: "projects#search", as: "projects_search"
  root to: "pages#home"
  get "/subscribed", to: "pages#subscribed"
  authenticate :user, lambda { |u| u.admin? } do
    get "/site_admin/home", to: "site_admin#home"
    post "/site_admin/github_projects", to: "site_admin#github_projects", as: "site_admin_github_projects"
    post "/site_admin/tags", to: "site_admin#tags", as: "site_admin_tags"
    mount Sidekiq::Web => "/sidekiq"
  end
  get '/submit', to: "submissions#new", as: "new_submission"
  post '/submissions', to: "submissions#create", as: "create_submission"
  get "tags/:tag_name", to: "tags#show", as: "tag_show"
  get "/projects/:id/preview", to: "projects#preview", as: "project_preview"
  resources :projects, only: [:new, :show, :create, :edit, :update]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get "pages/:key", to: "pages#static", as: "static_page"

  get "/blog", to: "articles#index", as: "articles"
  get "/blog/:id", to: "articles#show", as: "article"
  get "/blog/:id/edit", to: "articles#edit", as: "edit_article"
  get "/blogs/new", to: "articles#new", as: "new_article"
  post "/blog", to: "articles#create"
  post "/blogs/:id", to: "articles#update", as: "update_article"
end

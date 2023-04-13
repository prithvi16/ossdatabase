require 'sidekiq/web'

Rails.application.routes.draw do
  get 'projects/browse', to: 'tags#index', as: 'projects_browse'
  post 'projects/search_suggestions', to: 'projects#search_suggestions', as: 'projects_search_suggestions'
  get '/search', to: 'projects#search', as: 'search'
  root to: 'pages#home'
  get '/projects', to: 'projects#filter', as: 'projects_filter'

  get '/subscribed', to: 'pages#subscribed'

  authenticate :user, ->(u) { u.admin? } do
    get '/site_admin/home', to: 'site_admin#home', as: 'admin_dashboard'
    post '/site_admin/github_projects', to: 'site_admin#github_projects', as: 'site_admin_github_projects'
    post '/site_admin/tags', to: 'site_admin#tags', as: 'site_admin_tags'
    mount Sidekiq::Web => '/sidekiq'
    mount Blazer::Engine, at: 'blazer'
  end

  get '/submit', to: 'submissions#new', as: 'new_submission'
  post '/submissions', to: 'submissions#create', as: 'create_submission'
  delete '/submissions/:id', to: 'submissions#destroy', as: 'delete_submission'

  get 'tags/:tag_name', to: 'tags#show', as: 'tag_show'
  get '/projects/:id/preview', to: 'projects#preview', as: 'project_preview'
  resources :projects, only: %i[new show create edit update]
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'pages/:key', to: 'pages#static', as: 'static_page'

  # Blog
  get '/blog', to: 'articles#index', as: 'articles'
  get '/blog/:id', to: 'articles#show', as: 'article'
  get '/blog/:id/edit', to: 'articles#edit', as: 'edit_article'
  get '/blogs/new', to: 'articles#new', as: 'new_article'
  post '/blog', to: 'articles#create'
  post '/blog/:id', to: 'articles#update', as: 'update_article'

  # Projects by license
  get '/open-source-projects-with-:key-license', to: 'open_source#projects_with_license',
                                                 as: 'projects_with_license'

  # Open Source guides
  get '/open-source', to: 'open_source#index', as: 'open_source'
  get '/open-source-licenses', to: 'open_source#licenses_index', as: 'licenses_index'
  get '/licenses/:id', to: 'open_source#license', as: 'license'
  get '/open-source-license-picker', to: 'open_source#license_picker', as: 'open_source_license_picker'
  get '/list-of-open-source-licenses', to: 'open_source#licenses_list', as: 'licenses_list'

  # New browsing experience for tags
  get '/open-source-alternatives', to: 'open_source#alternatives', as: 'open_source_alternatives'
  get '/usecase/:id', to: 'open_source#alternative_usecase', as: 'open_source_usecase',
                      constraints: { id: /open-source-[a-z0-9]+(?:-[a-z0-9]+)*-software/ }
end

ActiveAdmin.register StaticPage do
  permit_params :key, :content, :title, :description
end

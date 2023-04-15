ActiveAdmin.register License do
  permit_params :name, :key, :content, :slug, :description
end

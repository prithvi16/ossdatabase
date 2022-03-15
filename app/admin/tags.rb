ActiveAdmin.register Tag do
  permit_params :name, :tag_type, :top_category, :slug
end

ActiveAdmin.register Project do
  permit_params :name, :tag_line, :website, :description, :first_release, :last_release, :premium, :slug, :visible, :reviewed, :proprietary
end

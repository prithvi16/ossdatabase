ActiveAdmin.register Submission do
  permit_params :name, :tagline, :description, :alternative_to, :website, :suggested_tags
end

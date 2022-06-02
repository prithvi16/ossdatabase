ActiveAdmin.register Submission do
  permit_params :name, :tagline, :description, :alternative_to, :website, :suggested_tags, :github_url, :logo_url, :proprietary, :premium
end

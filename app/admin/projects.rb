ActiveAdmin.register Project do

  permit_params :name, :website, :description, :first_release, :last_release, :premium

end

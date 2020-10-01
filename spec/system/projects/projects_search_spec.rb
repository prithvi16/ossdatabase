# frozen_string_literal: true

require "system_helper"

describe "Projects search" do

  before(:each) do 
      @sample_project = FactoryBot.create(:project)
  end 

  it "Searches project and visits the project" do
    visit projects_search_path
    fill_in 'project_name', with: @sample_project.name
    click_button 'Search'
    expect(page).to have_content(@sample_project.name)
    expect(page).to have_link(nil, href: project_path(@sample_project))
    click_link(nil, href: project_path(@sample_project))
    expect(page).to have_content(@sample_project.name)
  end

end

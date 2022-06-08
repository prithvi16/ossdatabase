# frozen_string_literal: true

require "system_helper"

describe "Projects search" do
  it "Shows project name in when searched in navbar" do

    # search in nav bar
    visit root_path
    project = FactoryBot.create(:project)
    tag = FactoryBot.create(:tag, tag_type: "usecase")
    project.tags << tag
    fill_in "Press enter to search", with: project.name
    expect(page).to have_content project.name
    fill_in "Press enter to search", with: tag.name
    expect(page).to have_content "#{tag.name} projects"
    click_link "#{tag.name} projects"
    expect(page).to have_content project.name
    expect(page).to have_content tag.name
    
    # Search on /search page
    project_2 = FactoryBot.create(:project)
    tag_2 = FactoryBot.create(:tag, tag_type: "usecase")
    project_2.tags << tag_2
    fill_in "Search for projects by name", with: project_2.name
    expect(page).to have_content project_2.name
    expect(page).to have_content tag_2.name.upcase
  end
end

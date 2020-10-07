# frozen_string_literal: true

require "system_helper"

describe "Projects create" do

  it "Shows errors when project is invalid" do
    visit new_project_path
    click_button 'Submit project'
    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Description can\'t be blank')
    expect(page).to have_content('Website can\'t be blank')
    expect(page).to have_content('Website invalid link format')
    expect(page).to have_content('Name can\'t be blank')
    expect(page).to have_content('Tag line can\'t be blank')

    example_project = FactoryBot.create(:project)
    fill_in 'Name*', with: example_project.name
    fill_in 'Tagline*', with: example_project.tag_line
    fill_in 'About project*', with: example_project.description
    fill_in 'Project website*', with: example_project.website
    fill_in 'First release', with: example_project.first_release
    fill_in 'Last release', with: example_project.last_release
  end
end

# frozen_string_literal: true

require "system_helper"

describe "Projects submission" do
  it "Shows errors when project is invalid" do
    visit new_submission_path

    example_project = FactoryBot.create(:project)
    fill_in "Name*", with: example_project.name
    fill_in "Tagline", with: example_project.tag_line
    fill_in "About project*", with: example_project.description
    fill_in "Project website", with: example_project.website

    expect { click_button "Submit Project →" }.to change { Submission.count }.by(1)
    expect(page).to have_content("Thank you for your submission!")
  end
end

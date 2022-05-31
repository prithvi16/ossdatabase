# frozen_string_literal: true

require "system_helper"

describe "Projects create" do
  it "Shows errors when project is invalid" do
    visit new_submission_path

    example_project = FactoryBot.create(:project)
    fill_in "Name*", with: example_project.name
    fill_in "Tagline", with: example_project.tag_line
    fill_in "About project*", with: example_project.description
    fill_in "Project website", with: example_project.website
  end
end

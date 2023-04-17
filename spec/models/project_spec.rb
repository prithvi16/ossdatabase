require 'rails_helper'

RSpec.describe Project, type: :model do
  let!(:project) { create(:project) } # Assuming you have a FactoryBot factory for projects
  let!(:tag) { create(:tag) } # Assuming you have a FactoryBot factory for tags

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:website) }
    it { should validate_presence_of(:tag_line) }
  end

  describe 'associations' do
    it { should have_many(:taggings) }
    it { should have_many(:tags).through(:taggings) }
    it { should have_one_attached(:avatar) }
  end

  describe '#invisible?' do
    it 'returns the opposite of visible' do
      expect(project.invisible?).to eq(!project.visible)
    end
  end

  describe '#tag_list' do
    it 'returns a comma-separated list of tag names' do
      project.tags << tag
      expect(project.tag_list).to eq(tag.name)
    end
  end

  describe '#any_tags_with?' do
    it 'returns true if there are any tags with the given tag_type' do
      project.tags << tag
      expect(project.any_tags_with?(tag.tag_type)).to be(true)
    end
  end

  describe '#tag_with' do
    it 'associates a tag with the project' do
      expect do
        project.tag_with('new_tag', 'new_tag_type')
      end.to change { project.tags.count }.by(1)
      expect(project.tags.last.name).to eq('new_tag')
      expect(project.tags.last.tag_type).to eq('new_tag_type')
    end
  end

  describe '.search' do
    let!(:project1) { create(:project, name: 'Ruby on Rails') }
    let!(:project2) { create(:project, name: 'React') }
    let!(:project3) { create(:project, name: 'Vue.js') }
    let!(:tech_tag) { create(:tag, tag_type: 'tech', name: 'Backend') }
    let!(:usecase_tag) { create(:tag, tag_type: 'usecase', name: 'Frontend') }
    let!(:license_tag) { create(:tag, tag_type: 'license', name: 'MIT') }
    let!(:platform_tag) { create(:tag, tag_type: 'platform', name: 'Web') }
    let!(:non_proprietary_project) { create(:project, proprietary: false) }
    let!(:proprietary_project) { create(:project, proprietary: true) }

    before do
      project1.tags << tech_tag
      project2.tags << usecase_tag
      project3.tags << license_tag
      project1.tags << platform_tag
    end

    describe '.search' do
      context 'when searching by name' do
        it 'returns projects matching the search query' do
          params = { pg_search_by_name: 'Ruby' }
          result = Project.search(params)

          expect(result).to include(project1)
          expect(result).not_to include(project2)
          expect(result).not_to include(project3)
        end
      end

      context 'when filtering by sidebar tags' do
        it 'returns projects that have any of the specified tags' do
          params = { sidebar_tag_ids: [tech_tag.id.to_s, usecase_tag.id.to_s].to_json.to_s }
          result = Project.search(params)

          expect(result).to include(project1)
          expect(result).to include(project2)
          expect(result).not_to include(project3)
        end
      end

      context 'when filtering by tag ids' do
        it 'returns projects that have all of the specified tags' do
          params = { "tech_tag_ids": [tech_tag.id.to_s], "platform_tag_ids": [platform_tag.id.to_s] }
          result_project_ids = Project.search(params.transform_keys(&:to_s)).ids

          expect(result_project_ids).to include(project1.id)
          expect(result_project_ids).not_to include(project2.id)
          expect(result_project_ids).not_to include(project3.id)
        end
      end

      context 'when filtering by proprietary' do
        it 'returns projects that are proprietary' do
          params = { open_source: 'true' }
          result = Project.search(params)

          expect(result).to include(non_proprietary_project)
          expect(result).not_to include(proprietary_project)
        end

        it 'returns all kinds of projects when no open_source param is provided' do
          params = {}
          result = Project.search(params)

          expect(result).to include(non_proprietary_project)
          expect(result).to include(proprietary_project)
        end
      end

      context 'when no search parameters are provided' do
        it 'returns projects ordered by updated_at in descending order' do
          project1.touch
          result = Project.search({})

          expect(result.first).to eq(Project.order('updated_at DESC').first)
        end
      end
    end
  end

  describe '.tagged_with_top_categories' do
    it 'returns projects with top category tags' do
      top_category_tag = create(:tag, top_category: true)
      project.tags << top_category_tag
      expect(Project.tagged_with_top_categories).to include(project)
    end
  end

  describe '.search_suggestions' do
    it 'returns search suggestions for a given query' do
      suggestions = Project.search_suggestions(project.name)

      expect(suggestions).to include(Project.where(id: project.id).select(:id, :name, :tag_line).first)
    end
  end

  describe '#tag_list=' do
    it 'associates tags with the project based on a comma-separated list of tag names' do
      tag_names = "#{tag.name}, new_tag"
      expect do
        project.tag_list = tag_names
      end.to change { project.tags.count }.by(2)
    end
  end
end

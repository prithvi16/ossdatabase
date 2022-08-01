class AttachGithubProjectLogoWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    github_data = GithubApi.client.repo(project.source_id)
    owner = github_data.try(:owner)
    if owner.present? && owner.type == "Organization"
      logo_url = owner.try(:avatar_url)
      if logo_url.present?
        begin
          file = Down.download(logo_url)
          project.avatar.attach(io: file, filename: file.original_filename)
        ensure
          file.close
          file.unlink
        end
      end
    end
  end
end

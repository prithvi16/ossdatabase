require "open-uri"
class FetchProjectLogoWorker
  include Sidekiq::Worker

  def perform(project_id)
    project = Project.find(project_id)
    begin
      file = Down.download(project.logo_url)
      project.avatar.attach(io: file, filename: file.original_filename)
    ensure
      file.close
      file.unlink
    end
  end
end

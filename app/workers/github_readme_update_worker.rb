class GithubReadmeUpdateWorker
  include Sidekiq::Worker

  def perform(project_id)
    GithubReadmeUpdaterService.new(project_id).update_readme
  end
end

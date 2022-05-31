class DailyRepoSourceSyncWorker
  include Sidekiq::Worker

  def perform
    all_projects = Project.where(source: "github").where("source_id is not null")
    counter = 0
    all_projects.each do |project|
      counter += 5
      GithubSyncWorker.perform_in(counter.seconds, project.id)
    end
  end
end

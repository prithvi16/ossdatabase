
class BaseWorker
  include Sidekiq::Worker

  def perform
  end
end

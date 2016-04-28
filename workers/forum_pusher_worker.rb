class ForumPusherWorker
  include Sidekiq::Worker

  @@iiet_pusher = IietPusher::ForumPusher.new('settings.yml', logger)

  sidekiq_options queue: :forum_cron

  def perform
    @@iiet_pusher.process
  end
end
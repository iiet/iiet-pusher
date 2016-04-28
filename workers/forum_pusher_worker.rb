class ForumPusherWorker
  include Sidekiq::Worker

  @@iiet_pusher = IietPusher::ForumPusher.new('settings.yml')

  sidekiq_options queue: :forum_cron

  def perform
    @@iiet_pusher.logger = logger
    @@iiet_pusher.process
  end
end
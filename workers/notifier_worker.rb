class NotifierWorker
  include Sidekiq::Worker

  sidekiq_options queue: :notifier

  def perform(url, items, title)
    return if items.empty?

    IietPusher::Notifier.new.notify_chat(
      url,
      title,
      items.first['link'],
      items.first['content'],
    )

    items.shift

    NotifierWorker.perform_async(url, items, title) unless items.empty?
  end
end
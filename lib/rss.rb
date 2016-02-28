require 'simple-rss'
require 'pry'

module IietPusher
  class Rss
    def initialize(settings, url)
      f = ForumInteractor.new(settings)
      response = f.get('https://forum.iiet.pl/feed.php?f=405&t=22606')
      rss = SimpleRSS.parse response

      notifier = Notifier.new(settings)
      binding.pry
      notifier.notify_chat(
        rss.channel.title.force_encoding(Encoding::UTF_8),
        rss.items.first.link.force_encoding(Encoding::UTF_8),
        rss.items.first.content.force_encoding(Encoding::UTF_8)
      )

    end
  end
end
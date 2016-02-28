require 'yaml'

module IietPusher
  autoload :Notifier, './lib/notifier'
  autoload :OauthInteractor, './lib/oauth_interactor'
  autoload :ForumInteractor, './lib/forum_interactor'
  class Pusher
    def self.process(file)
      settings = YAML.load(File.open(file))
      notifier = Notifier.new(settings)
      notifier.notify_chat('test', 'er', 'sersrer')
      f = ForumInteractor.new(settings)
      p f.get('https://forum.iiet.pl/feed.php?f=405&t=22606')
    end
  end

end

require 'yaml'

module IietPusher
  autoload :Notifier, './lib/notifier'
  autoload :OauthInteractor, './lib/oauth_interactor'
  autoload :ForumInteractor, './lib/forum_interactor'
  autoload :Rss, './lib/rss'
  class Pusher
    def self.process(file)
      settings = YAML.load(File.open(file))
      Rss.new(settings, '')
    end
  end

end

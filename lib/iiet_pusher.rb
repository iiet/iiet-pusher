require 'yaml'

module IietPusher
  autoload :Notifier, './lib/notifier'
  autoload :OauthInteractor, './lib/oauth_interactor'
  class Pusher
    def self.process(file)
      settings = YAML.load(File.open(file))
      notifier = Notifier.new(settings)
      notifier.notify_chat('test', 'er', 'sersrer')
      o = OauthInteractor.new(settings)
      o.send(:login)
    end
  end

end

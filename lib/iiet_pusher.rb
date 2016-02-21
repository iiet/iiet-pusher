require 'yaml'

module IietPusher
  autoload :Notifier, 'notifier'
  class Pusher
    def self.process(file)
      settings = YAML.load(File.open(file))
    end
  end

end

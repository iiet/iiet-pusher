require 'simple-rss'

module IietPusher
  class Rss
    def initialize(url)
      @rss = SimpleRSS.parse open('')
    end
  end
end
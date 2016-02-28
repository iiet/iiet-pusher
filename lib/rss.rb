require 'simple-rss'
require 'pry'

module IietPusher
  class Rss

    attr_reader :newest_time, :title

    def initialize(feed)
      @rss = SimpleRSS.parse(feed)
      @newest_time = @rss.items.first.published
      @title = @rss.channel.title.force_encoding(Encoding::UTF_8)
    end

    def data
      @rss.items
    end

    def only_newest(time)
      items = @rss.items.take_while { |item| item.published > time }
      deep_force_encoding(items)
    end

    def deep_force_encoding(items)
      arr = []
      items.each do |item|
        h = {}
        item.to_hash.each do |k, v|
          if v.respond_to?(:force_encoding)
            h[k] = v.force_encoding(Encoding::UTF_8)
          else
            h[k] = v
          end
        end

        arr << h
      end

      arr
    end
  end
end
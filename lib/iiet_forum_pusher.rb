require 'yaml'

module IietPusher
  class ForumPusher
    def initialize(file)
      @settings = YAML.load(File.open(file))
      @forum_interactor = ForumInteractor.new(@settings)
    end

    def process
      @settings['forum_feeds'].each do |subject|
        last_sync = ForumTime.last_sync_time(subject[0])
        last_sync_time = last_sync&.time

        atom_feed = @forum_interactor.get(subject[1])
        rss = Rss.new(atom_feed)
        newest_time = rss.newest_time

        create_or_update_forum_time(subject[0], last_sync, newest_time)
        next if last_sync_time.nil?

        items = rss.only_newest(last_sync_time).reverse
        next if items.empty?

        NotifierWorker.perform_async(
          subject[2],
          items,
          rss.title,
        )
      end
    end

    private

    def create_or_update_forum_time(id, last_sync, newest_time)
      return ForumTime.create(atom_id: id, time: newest_time) if last_sync.nil?
      last_sync.update_attribute(:time, newest_time) if last_sync.last_sync_time <= newest_time
    end
  end
end

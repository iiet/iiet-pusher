require 'yaml'

module IietPusher
  class ForumPusher
    def initialize(file)
      @settings = YAML.load(File.open(file))
      @forum_interactor = ForumInteractor.new(@settings)
    end

    def process
      @settings['forum_feeds'].each do |subject|
        last_sync = ForumTime.last_sync_time(subject[0]).time

        atom_feed = @forum_interactor.get(subject[1])
        rss = Rss.new(atom_feed)
        newest_time = rss.newest_time

        ForumTime.create(atom_id: subject[0], time: newest_time) if last_sync.nil? || last_sync <= newest_time
        return if last_sync.nil?

        items = rss.only_newest(last_sync).reverse
        return if items.empty?

        NotifierWorker.perform_async(
          subject[2],
          items,
          rss.title,
        )
      end
    end
  end

end

require 'rest-client'

module IietPusher
  class Notifier
    def initialize(settings)
      @settings = settings
    end

    def notify_chat(title, link, text)
      RestClient.post(@settings['chat_url'], {
        text: '',
        attachments: [
          {
            title: title,
            title_link: link,
            text: text,
            color: '#0000FF'
	        }
        ]
      }.to_json, content_type: :json)
    end
  end
end

require 'rest-client'

module IietPusher
  class Notifier
    def notify_chat(url, title, link, text)
      parsed_text = HtmlStyler.new(text).parse
      
      RestClient.post(url, {
        text: '',
        attachments: [
          {
            title: title,
            title_link: link.gsub!('amp;', ''),
            text: parsed_text,
            color: '#0000FF'
	        }
        ]
      }.to_json, content_type: :json)
    end
  end
end

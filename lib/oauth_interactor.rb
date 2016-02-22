require 'nokogiri'
require 'rest-client'
require 'open-uri'

module IietPusher
  class OauthInteractor
    def initialize(settings)
      @settings = settings
    end

    def login_now
      login
    end

    private

    def login
      p RestClient.post(@settings['forum_login_url'], {
        'authenticity_token' => authenticity_token,
        'student' => {
          'username' => @settings['forum']['login'],
          'password' => @settings['forum']['password']
          # 'remember_me' => 1,
        },
        'utf8' => '✓'
      },
      {
        'Content-Type' => 'application/x-www-form-urlencoded',
        'X-CSRF-TOKEN' => @csrf_token
      })
    end

    def authenticity_token
      page = Nokogiri::HTML(open(@settings['forum_login_url']))
      @csrf_token = page.xpath("//meta[@name='csrf-token']/@content").first.value

      page.css("input[name='authenticity_token']").first['value']
    end
  end
end
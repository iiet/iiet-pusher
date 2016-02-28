require 'rest-client'

module IietPusher
  class ForumInteractor
    def initialize(settings)
      @settings = settings
      @forum_session_cookies = nil
    end

    def get(url)
      RestClient.get(url, headers) do |response|
        if response.code == 200
          response
        else
          login_and_get(url)
        end
      end
    end

    private

    def headers
      { cookies: @forum_session_cookies } if @forum_session_cookies
    end

    def login_and_get(url)
      OauthInteractor.new(@settings).get_and_login_now(url) do |success_response, new_cookies|
        @forum_session_cookies = new_cookies
        success_response
      end
    end
  end
end
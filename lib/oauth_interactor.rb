require 'nokogiri'
require 'rest-client'

module IietPusher
  class OauthInteractor
    def initialize(settings)
      @settings = settings
    end

    def get_and_login_now(url)
      response = get_and_login(url)
      yield(response, @forum_session_cookies)
    end

    private

    def get_and_login(url)
      RestClient.get(url, { accept: 'text/html' }) do |response, request, result, &block|
        if [301, 302, 307].include? response.code
          response.follow_redirection(request, result, &block)
        else
          authenticity_token(response)
        end
      end

      RestClient.post(@settings['forum_login_url'], payload, headers) do |response, request, result, &block|
        after_login_redirections(response)
      end
    end

    def after_login_redirections(response)
      url = response.headers[:location]

      RestClient.get(url, { cookies: response.cookies }) do |response2, request, result, &block|
        if [301, 302, 307].include? response2.code
          @forum_session_cookies = response2.cookies
          response2.follow_redirection(request, result, &block)
        else
          # success
          response2
        end
      end
    end

    def payload
      {
        'student' => {
          'username' => @settings['forum']['login'],
          'password' => @settings['forum']['password'],
          'remember_me' => 1,
        }
      }
    end

    def headers
      {
        :'X-CSRF-TOKEN' => @csrf_token,
        cookies: @cookies
      }
    end

    def authenticity_token(page_html)
      page = Nokogiri::HTML(page_html)

      @csrf_token = page.xpath("//meta[@name='csrf-token']/@content").first.value
      @cookies = page_html.cookies
    end
  end
end
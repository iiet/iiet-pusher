module IietPusher
  class HtmlStyler
    def initialize(html_styled_text)
      @html = html_styled_text
    end

    def parse
      change_br!
      change_block_quote!
      change_font!

      remove_all_html!
      @html
    end

    private

    def change_br!
      @html.gsub!(/<br(\s*\/)?>/, "\n")
    end

    def change_block_quote!
      @html.gsub!(/<(|\/)blockquote[^>]*>/, "\n```")
    end

    def change_font!
      @html.gsub!(/<(|\/)strong(\s*)>/, '*')
      @html.gsub!(/<(|\/)strong(\s*)>/, '_')
    end

    def remove_all_html!
      @html.gsub!(/<(|\/)[^>]*>/, '')
    end
  end
end
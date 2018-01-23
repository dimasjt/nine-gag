module NineGag
  class Scraper
    def initialize(path)
      @path = path
    end

    # path = ":section/:type"
    # next_page = "last_id"
    def index(next_page = nil)
      url = full_url(@path)

      headers = {
        Accept: 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        params: { id: next_page }
      }

      RestClient.get(url, headers)
    end

    # path = "gag/:id"
    def show
      url = full_url("gag/#{@path}")

      Nokogiri::HTML(open(url))
    end

    def comments(next_page)
      url = 'http://comment-cdn.9gag.com/v1/cacheable/comment-list.json'
      params = {
        appId: "a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b",
        url: full_url("gag/#{@path}"),
        count: 10,
        level: 2,
        order: 'score',
        mentionMapping: true,
        origin: '9gag.com'
      }
      params.merge(ref: next_page) unless next_page.nil?

      RestClient.get(url, { params: params })
    end

    private

    def full_url(path)
      # "https://9gag.com/v1/group-posts/group/gif/type/hot"
      "http://9gag.com/v1/group-posts/group/#{path}"
    end
  end
end

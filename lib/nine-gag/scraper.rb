module NineGag
  class Scraper
    def initialize(path)
      @path = path
    end

    # path = ":section/:type"
    # next_page = "last_id"
    def index(next_page = nil)
      url = full_url(@path)

      if next_page.nil?
        scrape_html(url).search('article')
      else
        generate_json_posts(url, next_page)
      end
    end

    # path = "gag/:id"
    def show
      url = full_url("gag/#{@path}")

      scrape_html(url).search('article').first
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
      "http://9gag.com/#{path}"
    end

    # will return Array of Nokogiri
    def generate_json_posts(path, next_page)
      items = JSON.parse(scrape_json(path, next_page).body)["items"]

      items.map { |item| scrape_html(item.last).search('article').first }
    end

    def scrape_json(path, next_page)
      headers = {
        Accept: 'application/json',
        'X-Requested-With': 'XMLHttpRequest',
        params: { id: next_page, c: 10 }
      }

      RestClient.get(path, headers)
    end

    # scrape html or from path
    def scrape_html(path)
      Nokogiri::HTML(path_or_html(path))
    end

    # check parameter if path or html
    def path_or_html(data)
      # if path
      if data.length < 50
        open data
      else
        data
      end
    end
  end
end

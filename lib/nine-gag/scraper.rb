require 'ostruct'

module NineGag
  class Scraper
    # path = ":section/:type"
    # next_page = "last_id"
    def self.index(path, next_page = nil)
      data = if next_page.nil?
        scrape_html(path)
      else
        generate_json_posts(path, next_page)
      end

      generate_index_data(data, next_page)
    end

    # path = "gag/:id"
    def self.show(path)
      generate_show_data(scrape_html(path).search('article').first)
    end

    private

    # will return Array of Nokogiri
    def self.generate_json_posts(path, next_page)
      items = JSON.parse(scrape_json(path, next_page).body)["items"]

      items.map { |item| scrape_html(item.last).search('article').first }
    end

    def self.scrape_json(path, next_page)
      RestClient.get(path,
        { Accept: 'application/json', "X-Requested-With": 'XMLHttpRequest',
          params: { id: next_page, c: 10 }
        }
      )
    end

    # scrape html or from path
    def self.scrape_html(path)
      Nokogiri::HTML(path_or_html(path))
    end

    # check parameter if path or html
    def self.path_or_html(data)
      # if path
      if data.length < 50
        open data
      else
        data
      end
    end

    def self.generate_show_data(post, index = false)
      if index
        title = post.search('h2.badge-item-title .badge-evt')
      else
        title = post.search('h2.badge-item-title')
      end

      post_meta = post.search('p.post-meta').first

      post_data = {
        id: post.attribute('data-entry-id').value,
        title: title.text.strip,
        url: post.attribute('data-entry-url').value,
        image: image_data(post.search('div.badge-post-container a img').first),
        comments_count: post_meta.search('a.comment').first.text.sub(' comments', '').sub(',', '').strip.to_i,
        points: post_meta.search('a.point').first.text.sub(' points', '').sub(',', '').strip,
        media: media_data(post.search('video').first)
      }

      OpenStruct.new(post_data)
    end

    def self.generate_index_data(scrape, next_page)
      data = next_page.nil? ? scrape.search('article') : scrape

      data.map do |post|
        generate_show_data(post)
      end
    end

    def self.image_data(image)
      return nil if image.nil?

      image.attribute('src').value
    end

    def self.media_data(media)
      return nil if media.nil?
      videos = media.search('source')
      {
        poster: media.attribute('poster').value,
        mp4: videos.first.attribute('src').value,
        webm: videos.last.attribute('src').value
      }
    end
  end
end

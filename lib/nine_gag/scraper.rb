require 'ostruct'

module NineGag
  class Scraper
    # path = ":section/:type"
    def self.index(path)
      generate_index_data(scrape(path))
    end

    # path = "gag/:id"
    def self.show(path)
      generate_show_data(scrape(path).search('article').first)
    end

    private

    def self.scrape(path)
      @scrape ||= Nokogiri::HTML(open("http://9gag.com/#{path}"))
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

    def self.generate_index_data(scrape)
      scrape.search('article').map do |post|
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

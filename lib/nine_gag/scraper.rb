module NineGag
  class Scraper
    def self.get(path)
      url = "http://9gag.com/#{path}"
      scrape = Nokogiri::HTML(open(url))

      generate_data(scrape)
    end

    private

    def self.generate_data(scrape)
      scrape.search('article').map do |data|
        title = data.search('h2.badge-item-title .badge-evt').first
        post_meta = data.search('p.post-meta').first

        {
          title: title.text.strip,
          url: title.attribute('href').value,
          img: image_data(data.search('div.badge-post-container a img').first),
          comments: post_meta.search('a.comment').first.text.sub(' comments', '').strip,
          points: post_meta.search('a.point').first.text.sub(' points', '').strip,
          media: media_data(data.search('video').first)
        }
      end
    end

    def self.image_data(img)
      return nil if img.nil?

      img.attribute('src').value
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

module NineGag
  class Generate
    def initialize(data)
      @data = data
    end

    def index
      @data.map do |post|
        generate_show_data(post, true)
      end
    end

    def show
      generate_show_data(@data)
    end

    def comments
      @data.map do |comment|
        generated_comment = generate_comment_data(comment)
        generated_comment.merge!(
          children: [],
          order_key: comment["orderKey"]
        )

        unless comment["children"].empty?
          comment["children"].each do |child|
            generated_comment[:children].push generate_comment_data(child)
          end
        end

        generated_comment
      end
    end

    private

    def generate_comment_data(comment)
      {
        id: comment["commentId"],
        text: comment["text"],
        timestamp: comment["timestamp"],
        user_id: comment["userId"],
        permalink: comment["permalink"],
        points: comment["likeCount"],
        media: media_comment_data(comment),
        user: user_comment(comment["user"])
      }
    end

    def user_comment(user)
      {
        id: user["userId"],
        avatar: user["avatarUrl"],
        username: user["displayName"]
      }
    end

    def media_comment_data(comment)
      return nil if comment["embedMediaMeta"]["embedImage"].nil?

      {
        jpg: media_comment(comment, "image"),
        gif: media_comment(comment, "animated"),
        mp4: media_comment(comment, "video")
      }
    end

    def media_comment(comment, media)
      comment["embedMediaMeta"].fetch("embedImage", {}).fetch(media, {}).fetch("url", nil)
    end

    def generate_show_data(post, index = false)
      if index
        title = post.search('h2.badge-item-title .badge-evt')
      else
        title = post.search('h2.badge-item-title')
      end

      post_meta = post.search('p.post-meta').first

      {
        id: post.attribute('data-entry-id').value,
        title: title.text.strip,
        url: post.attribute('data-entry-url').value,
        image: image_data(post.search('div.badge-post-container a img').first),
        comments_count: post_meta.search('a.comment').first.text.sub(' comments', '').sub(',', '').strip.to_i,
        points: post_meta.search('.badge-item-love-count').first.text.sub(',', '').to_i,
        media: media_data(post.search('video').first),
        nsfw: !post.search('.nsfw-post').empty?
      }
    end

    def image_data(image)
      return "https://placeholdit.imgix.net/~text?txtsize=60&txt=NSFW&w=500&h=350&bg=000000&txtclr=ffffff" if image.nil?

      image.attribute('src').value
    end

    def media_data(media)
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

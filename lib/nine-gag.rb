require 'rest-client'
require 'json'

class NineGag
  DEFAULT = %i[hot trending fresh].freeze

  def self.comments(id)
    url = 'http://comment-cdn.9gag.com/v1/cacheable/comment-list.json'
    params = {
      appId: "a_dd8f2b7d304a10edaf6f29517ea0ca4100a43d1b",
      url: "http://9gag.com/gag/#{id}",
      count: 10,
      level: 2,
      order: 'score',
      mentionMapping: true,
      origin: '9gag.com'
    }
    # params.merge(ref: next_page) unless next_page.nil?

    begin
      result = RestClient.get(url, { params: params })
      data = JSON.parse(result.body, symbolize_names: true)[:payload][:comments].map do |c|
        user = c[:user]
        comment = {
          id: c[:commentId],
          text: c[:text],
          timestamp: c[:timestamp],
          level: c[:level],
          likes_count: c[:likeCount],
          dislikes_count: c[:dislikeCount],
          permalink: c[:permalink],
          user: {
            user_id: user[:userId],
            avatar_url: user[:avatarUrl],
            display_name: user[:displayName]
          }
        }
      end
      {
        status: "success",
        data: data
      }
    rescue RestClient::ExceptionWithResponse => e
      {
        status: "failed",
        message: e.response
      }
    end
  end

  def self.method_missing(method_name, *args, &block)
    opts = args[0] || {}
    type = opts.fetch(:type, "hot")
    after = opts.fetch(:after, nil)
    raise ArgumentError, "type is invalid, only :fresh or :hot" unless %w[hot fresh].include?(type.to_s)

    group, type =
      if DEFAULT.include?(method_name)
        ["default", method_name]
      else
        [method_name, type]
      end

    post_scrape(group, type, after)
  end

  private

  def self.post_scrape(group, type, after = nil)
    url = "https://9gag.com/v1/group-posts/group/#{group}/type/#{type}"
    headers = {
      Accept: 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      params: { after: after }
    }

    begin
      result = RestClient.get(url, headers)
      data =
        JSON.parse(result.body, symbolize_names: true)[:data][:posts].map do |post|
          p = {
            id: post[:id],
            title: post[:title],
            url: post[:url],
            comments_count: post[:commentsCount],
            points: post[:upVoteCount],
            nsfw: !post[:nsfw].zero?,
            video: false,
            media: {
              image: post[:images][:image700][:url],
              poster: post[:images][:image460][:url]
            },
            tags: post[:tags].map {|t| t[:key]}
          }

          if post[:type] == "Animated"
            p[:video] = true
            p[:media].merge!(
              mp4: post[:images][:image460sv][:url],
              webvm: post[:images][:image460svwm][:url]
            )
          end

          p
        end

      {
        status:  "success",
        data: data
      }
    rescue RestClient::ExceptionWithResponse => e
      {
        status: "failed",
        message: e.response
      }
    end
  end
end

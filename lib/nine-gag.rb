require 'rest-client'
require 'json'

class NineGag
  DEFAULT = %w[hot trending fresh].freeze

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
      {
        status: "success",
        data: JSON.parse(result.body, symbolize_names: true)[:payload][:comments]
      }
    rescue RestClient::ExceptionWithResponse => e
      {
        status: "failed",
        message: e.response
      }
    end
  end

  def self.method_missing(method_name, *args, &block)
    group =
      if DEFAULT.include?(method_name)
        "default"
      else
        method_name
      end

    opts = args[0] || {}
    type = opts.fetch(:type, nil)
    after = opts.fetch(:after, nil)

    type = %w[hot fresh].include?(type) ? type : "hot"
    post_scrape(group, type, after)
  end

  private

  def self.post_scrape(group = "default", type = "hot", after = nil)
    url = "https://9gag.com/v1/group-posts/group/#{group}/type/#{type}"
    headers = {
      Accept: 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      params: { after: after }
    }

    begin
      result = RestClient.get(url, headers)
      {
        status:  "success",
        data: JSON.parse(result.body, symbolize_names: true)[:data][:posts]
      }
    rescue RestClient::ExceptionWithResponse => e
      {
        status: "failed",
        message: e.response
      }
    end
  end
end

require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'json'

require 'nine-gag/version'
require 'nine-gag/scraper'
require 'nine-gag/generate'

module NineGag
  def self.index(path, next_page = nil)
    data = NineGag::Scraper.new(path).index(next_page)

    NineGag::Generate.new(data).index
  end

  def self.show(path)
    data = NineGag::Scraper.new(path).show

    NineGag::Generate.new(data).show
  end

  def self.comments(id, next_page = nil)
    data = NineGag::Scraper.new(id).comments(next_page)

    NineGag::Generate.new(data).comments
  end
end

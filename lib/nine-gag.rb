require 'open-uri'
require 'nokogiri'
require 'rest-client'
require 'json'

require 'nine-gag/version'
require 'nine-gag/scraper'
require 'nine-gag/generator'

module NineGag
  def self.index(path, next_page = nil)
    NineGag::Scraper.index(full_url(path), next_page)
  end

  def self.show(path)
    NineGag::Scraper.show(full_url("gag/#{path}"))
  end

  private

  def self.full_url(path)
    "http://9gag.com/#{path}"
  end
end

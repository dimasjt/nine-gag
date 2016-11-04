require 'test_helper'

class NineGag::ScraperTest < Minitest::Test
  def test_that_have_test
    refute_nil NineGag::Scraper::TEST
  end
end

require 'test_helper'

class NineGag::VersionTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil NineGag::VERSION
  end
end

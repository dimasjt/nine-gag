$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nine-gag'

require 'minitest/autorun'
require 'minitest/reporters'

require 'pry'

Minitest::Reporters.use!

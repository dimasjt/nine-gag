require 'test_helper'

describe "NineGag" do
  before do
    @result = NineGag.trending
    @post = @result[:data].first
  end

  describe '#group' do
    it 'should return success' do
      assert_equal @result[:status], 'success'
    end

    it 'can show next page of posts' do
      result = NineGag.hot({ after: @post[:id] })
      assert_equal result[:data][0][:title], @result[:data][1][:title]
    end

    it 'should return Fixnum of points' do
      assert_equal @post[:points].class, Fixnum
    end

    it 'should return Fixnum of comments count' do
      assert_equal @post[:comments_count].class, Fixnum
    end
  end

  describe '#comments' do
    it 'should return comments of post' do
      comments = NineGag.comments(@post[:id])

      assert_equal comments[:status], 'success'
      assert_equal comments[:data].class, Array
    end
  end
end

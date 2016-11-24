require 'test_helper'

describe NineGag do
  before do
    @posts = NineGag.index('hot')
  end

  describe '#index' do
    it 'should return array of post' do
      assert_equal @posts.class, Array
    end

    it 'can show next page of posts' do
      posts = NineGag.index('hot', @posts.last[:id])
      assert_equal posts.class, Array
    end

    it 'should not nil if gif post' do
      post = NineGag.index('gif/hot').first
      assert post[:media] != nil
    end

    it 'should return Fixnum of points' do
      assert_equal @posts.first[:points].class, Fixnum
    end

    it 'should return Fixnum of comments count' do
      assert_equal @posts.first[:comments_count].class, Fixnum
    end

    it 'should return true if nsfw post' do
      post = NineGag.index('nsfw/hot').first

      assert post[:nsfw]
    end
  end

  describe '#show' do
    it 'should return openstruct' do
      post = NineGag.show(@posts.first[:id])

      assert_equal post.class.name, 'Hash'
    end
  end
end

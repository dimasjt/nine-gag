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
      posts = NineGag.index('hot', @posts.last.id)
      assert_equal posts.class, Array
    end
  end

  describe '#show' do
    it 'should return openstruct' do
      post = NineGag.show(@posts.first.id)

      assert_equal post.class.name, 'OpenStruct'
    end
  end
end

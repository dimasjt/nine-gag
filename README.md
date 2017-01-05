[![Gem Version](https://badge.fury.io/rb/nine-gag.svg)](https://badge.fury.io/rb/nine-gag)
[![Build Status](https://travis-ci.org/dimasjt/nine-gag.svg?branch=develop)](https://travis-ci.org/dimasjt/nine-gag)
[![Code Climate](https://codeclimate.com/github/dimasjt/nine-gag/badges/gpa.svg)](https://codeclimate.com/github/dimasjt/nine-gag)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nine-gag', '>= 0.2.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nine-gag

## Usage

* [Posts](https://github.com/dimasjt/nine-gag/tree/develop#get-posts)
* [Detail post](https://github.com/dimasjt/nine-gag/tree/develop#get-detail-post)
* [Comments post](https://github.com/dimasjt/nine-gag/tree/develop#get-comments-post)

### Get Posts
#### Request
```ruby
# http://9gag.com/funny/hot
NineGag.index('funny/hot')
```

#### Response
```ruby
[
  {
    :id => "ajqgWZp",
    :title => "How deal with a Warlord",
    :url => "http://9gag.com/gag/ajqgWZp",
    :image => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460s.jpg",
    :comments_count => 28,
    :points => 464,
    :media =>  {
      :poster => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460s.jpg",
      :mp4 => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460sv.mp4",
      :webm => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460svwm.webm"
    }
  },
  {
    :id => "aERpNWM",
    :title => "Some people really deserve this high-five",
    :url => "http://9gag.com/gag/aERpNWM",
    :image => "http://img-9gag-fun.9cache.com/photo/aERpNWM_460s.jpg",
    :comments_count => 166,
    :points => 6388,
    :media => nil
  },
  ....
]
```

### Load more data
```ruby
NineGag.index('funny/hot', :last_id_post)

# example
# page 1
posts = NineGag.index('funny/hot')

# page 2
last_id = posts.last[:id]
posts = NineGag.index('funny/hot', last_id)
```

### Get Detail Post
#### Request
```ruby
post = NineGag.show(:post_id)
```

#### Response
```ruby
{
  :id => "ajqgWZp",
  :title => "How deal with a Warlord",
  :url => "http://9gag.com/gag/ajqgWZp",
  :image => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460s.jpg",
  :comments_count => 28,
  :points => 464,
  :media =>  {
    :poster => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460s.jpg",
    :mp4 => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460sv.mp4",
    :webm => "http://img-9gag-fun.9cache.com/photo/ajqgWZp_460svwm.webm"
  }
}
```

### Get Comments Post
#### Request
```ruby
NineGag.comments(:post_id)
```

#### Response
```ruby
[
  {
    :id => "c_148359676629369444",
    :text => "http://i.memeful.com/media/post/YRO9Qqw_700wa_0.gif",
    :timestamp => 1483596766,
    :user_id => "u_13994024017199",
    :permalink => "http://9gag.com/gag/a6Mg7mL#cs_comment_id=c_148359676629369444",
    :points => 25,
    :media => {
      :jpg => "http://img-comment-fun.9cache.com/media/9a1d1430145033986894189858_700w_0.jpg",
      :gif => "http://img-comment-fun.9cache.com/media/9a1d1430145033986894189858_700wa_0.gif",
      :mp4 => "http://img-comment-fun.9cache.com/media/9a1d1430145033986894189858_700wv_0.mp4"
    },
    :user => {
      :id => "u_13994024017199",
      :avatar => "http://accounts-cdn.9gag.com/media/avatar/17248840_100_13.jpg",
      :username=>"mister_widodo"
    },
    :children => [
      {
        :id => "c_148359764385634228",
        :text => "@mister_widodo perfect",
        :timestamp => 1483597643,
        :user_id => "u_145203259185649618",
        :permalink => "http://9gag.com/gag/a6Mg7mL#cs_comment_id=c_148359764385634228",
        :points => 1,
        :media => nil,
        :user => {
          :id => "u_145203259185649618",
          :avatar => "http://accounts-cdn.9gag.com/media/avatar/27974937_100_1.jpg",
          :username => "psoric39"
        }
      }
    ],
    :order_key=>"score_00000000001004_14835967662936"
  },
  .......
]
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimasjt/nine-gag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


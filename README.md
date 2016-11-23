[![Build Status](https://travis-ci.org/dimasjt/nine-gag.svg?branch=develop)](https://travis-ci.org/dimasjt/nine-gag)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nine-gag', '>= 0.1.2'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nine-gag

## Usage

### Get data from /section/type
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
    :points => "464",
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
    :points => "6388",
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
posts = NineGag.index('gif/hot', last_id)
```

### Detail post
```ruby
post = NineGag.show(:post_id)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimasjt/nine-gag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


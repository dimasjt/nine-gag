[![Gem Version](https://badge.fury.io/rb/nine-gag.svg)](https://badge.fury.io/rb/nine-gag)
[![Build Status](https://travis-ci.org/dimasjt/nine-gag.svg?branch=develop)](https://travis-ci.org/dimasjt/nine-gag)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nine-gag', '>= 1.0.0'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nine-gag

## Usage

* [Posts](#get-posts)
* [Comments post](#get-comments)

### Get Posts
#### Request
```ruby
NineGag.trending # http://9gag.com/trending
NineGag.hot # http://9ag.com/hot
NineGag.gif({ type: "fresh" }) # http://9gag.com/gif/fresh
NineGag.nsfw({ type: "hot" }) # http://9gag.com/nsfw/hot
NineGag.cute({ type: "fresh", after: "aAxVod2" }) # http://9gag.com/cute/fresh pagination after post id aAxVod2
```

### Result
```json
{
  :status=>"success",
  :data=> [
    {
      :id=>"ayXpOeY",
      :title=>"Too cold",
      :url=>"http://9gag.com/gag/ayXpOeY",
      :comments_count=>5,
      :points=>35,
      :nsfw=>true,
      :video=>true,
      :media=>{
        :image=>"https://img-9gag-fun.9cache.com/photo/ayXpOeY_460s.jpg",
        :poster=>"https://img-9gag-fun.9cache.com/photo/ayXpOeY_460s.jpg",
        :mp4=>"https://img-9gag-fun.9cache.com/photo/ayXpOeY_460sv.mp4",
        :webvm=>"https://img-9gag-fun.9cache.com/photo/ayXpOeY_460svwm.webm"
      },
      :tags=>["Awesome"]
    },
    ....
  ]
}
```

### Get Comments

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimasjt/nine-gag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


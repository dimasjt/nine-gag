| master | develop |
| ------ | ------- |
| [![Build Status](https://travis-ci.org/dimasjt/nine-gag.svg?branch=master)](https://travis-ci.org/dimasjt/nine-gag) | [![Build Status](https://travis-ci.org/dimasjt/nine-gag.svg?branch=develop)](https://travis-ci.org/dimasjt/nine-gag) |

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nine-gag'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nine-gag

## Usage

### Get data from /section/type
```ruby
# http://9gag.com/gif/hot
NineGag::Scraper.index('gif/hot')
```

### Load more data
```ruby
NineGag::Scraper.index('gif/hot', :last_id_post)

# example
# page 1
posts = NineGag::Scraper.index('gif/hot')

# page 2
last_id = posts.last.id
posts = NineGag::Scraper.index('gif/hot', last_id)
```

### Detail post
```ruby
post = NineGag::Scraper.show(:post_id)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/dimasjt/nine-gag. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


# CachedMechanize

is a small wrapper around [Mechanize](https://github.com/sparklemotion/mechanize) to enable caching for GET requests.

## Installation

Add this line to your application's Gemfile:

    gem 'cached_mechanize'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cached_mechanize

## Usage

Right now there is only a file based caching backend. There might follow more in the future (redis, etc.).

To configure the backend use this syntax:

    CachedMechanize.configure do |config|
      config.cache_class = CachedMechanize::CacheBackends::FileCache
      config.cache_options = {
        path: "/path/to/my/cached_files"
      }
    end

Now you can use this class like you would use Mechanize:

    agent = CachedMechanize.new
    doc = agent.get('http://www.imdb.com')

By default all retrieved pages will be cached for one day (86400 seconds). To change this behaviour you can provide an `expires_after` option:

    doc = agent.get('http://www.imdb.com', expires_after: 42)

Note that the syntax has changed! If you want to provide parameters, additional headers or a referer, you can do it like this:

    doc = agent.get('http://www.imdb.com', {
      referer: 'http://thatothersite.com',
      expires_after: 42
    })

## TO-DO

 - add more backends
 - add tests

## Contributing

1. Fork it ( http://github.com/wukerplank/cached_mechanize/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

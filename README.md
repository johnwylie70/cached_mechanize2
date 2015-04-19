# CachedMechanize

is a small wrapper around [Mechanize](https://github.com/sparklemotion/mechanize) to enable caching for GET requests.

## Installation

Add this line to your application's Gemfile:

    gem 'cached_mechanize2'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cached_mechanize2

## Usage

Right now there is only a file based caching backend. There might follow more in the future (redis, etc.).

To configure the backend use this syntax:

    CachedMechanize.configure do |config|
      config.cache_class = CachedMechanize::CacheBackends::FileCache
      config.cache_options = {
        :path => "/path/to/my/cached_files"
      }
    end

Now you can use this class like you would use Mechanize:

    agent = CachedMechanize.new
    doc = agent.get('http://www.imdb.com')

## Quick deviation from original code

The original author 'wukerplank' added some code to control cache time-out, but I dont need this and I discovered that the overloading and change of syntax from current version mechanize's 'get'  command seemed to cause errors in running, and the link click function stopped working, so i left the expire time in as a hard coded value and returned the 'get' method signature back to normal.

Here is what is now removed, and can be ignored (easy to fiddle with the code if you need this)

    By default all retrieved pages will be cached for one day (86400 seconds). To change this behaviour you can provide an `expires_after` option:

        doc = agent.get('http://www.imdb.com', expires_after: 42)

    Note that the syntax has changed! If you want to provide parameters, additional headers or a referer, you can do it like this:

        doc = agent.get('http://www.imdb.com', {
        referer: 'http://thatothersite.com',
        expires_after: 42
        })


## Troubleshooting

Im pretty new to making a GEM and it was not working on my mac when I downloaded it for testing, so instead I put the folder as a sub-folder in my project folder and included the code like this:
    
    require './cached_mechanize2/lib/cached_mechanize'
    
Let me know if I did something wrong in the gem or if its just the way my Mac is configured!

I did this to create the gem:

    gem build cached_mechanize2.gemspec 
    
    gem push cached_mechanize2-0.1.1.gem
    

require "mechanize"

class CachedMechanize < Mechanize

  # Getter/Setter for the cache_class attribute
  def self.cache_class #:nodoc:
    @@cache_class
  end
  def self.cache_class=(cache_class) #:nodoc:
    @@cache_class = cache_class
  end
  @@cache_class = nil

  # Getter/Setter for the cache_options attribute
  def self.cache_options #:nodoc:
     @@cache_options
  end
  def self.cache_options=(cache_options) #:nodoc:
    @@cache_options = cache_options
  end
  @@cache_options = {}

  def initialize(*args)
    super
    @cache = (@@cache_class || CachedMechanize::CacheBackends::FileCache).new(@@cache_options)
  end

  # parameters:
  #  - uri
  #  - options
  #
  # possible options are:
  #  - +parameters+ (default: [])
  #  - +referer+ (default: nil)
  #  - +headers+ (default: {})
  #  - +expires_after+ in seconds (default: 86400 = 1 day)
  def get(uri, options = {})
    options[:expires_after] ||= 86400

    data = nil

    if @cache.present?(uri, options[:expires_after])
      data = Mechanize::Page.new(URI(uri), nil, @cache.retrieve(uri), nil, self)
    else
      data = super(uri, options[:parameters], options[:referer], options[:headers])
      @cache.store(uri, data.body)
    end

    return data
  end

  ##
  #
  # Example:
  #
  # CachedMechanize.configure do |config|
  #   config.cache_class = CachedMechanize::CacheBackends::FileCache
  #   config.cache_options = {
  #     path: "/path/to/my/cached_files"
  #   }
  # end
  #
  def self.configure(&block)
    yield self
  end
end

require "cached_mechanize/cache_backends/file_cache"

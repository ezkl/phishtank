require 'typhoeus'
require 'nokogiri'

require "phishtank/version"
require "phishtank/configuration"
require "phishtank/feed_request"
require "phishtank/feed_data"
require "phishtank/url_request"

module PhishTank
  BASE_URI = "http://data.phishtank.com"
  
  attr_accessor :configuration
  
  def self.configure(&block)
    yield configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.update_feed!
    request = FeedRequest.new
    request.get_update if request.update?
  end
  
  def self.search(url)
    URLRequest.new(url)
  end
  
  def self.api_key
    @configuration.api_key
  end
  
  def self.api_key=(api_key)
    @configuration = Configuration.new(api_key)
  end
  
  def self.temp_directory
    @configuration.temp_directory    
  end
  
  def self.etag
    @configuration.etag
  end
end

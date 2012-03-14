require "phishtank/version"
require "phishtank/configuration"
require "phishtank/request"
require "phishtank/data"

module PhishTank
  BASE_URI = "http://data.phishtank.com"
  
  attr_accessor :configuration
  
  def self.configure(&block)
    yield configuration
  end
  
  def self.configuration
    @configuration ||= Configuration.new
  end
  
  def self.update!
    request = Request.new
    request.get_update if request.update?
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

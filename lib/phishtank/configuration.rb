module PhishTank
  class Configuration
    attr_accessor :api_key, :temp_directory, :etag
    
    def initialize(api_key = "", temp_directory = "/tmp", etag = nil)
      @api_key        = api_key
      @temp_directory = temp_directory
      @etag           = etag
    end
  end
end
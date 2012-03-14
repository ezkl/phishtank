require 'ostruct'

module PhishTank
  class URLRequest
    attr_reader :url, :doc
    
    def initialize(url)
      @url = URI.encode(url)
    end
    
    def search
      response = Typhoeus::Request.post(search_uri, :params => params)
      parse_response(response.body)
      
      if in_database?
        result_data
      else
        false
      end
    end
    
    def in_database?
      in_database = @doc.xpath("/response/results/url0/in_database").text
      in_database =~ /true/ ? true : false 
    end
    
    def result_data
      search_result = @doc.xpath("/response/results/url0")
      result = OpenStruct.new
      result.url          = search_result.at("url").text
      result.in_database  = true
      result.phish_id     = search_result.at("phish_id").text
      result.detail_page  = search_result.at("phish_detail_page").text
      result.verified     = search_result.at("verified").text
      result.verified_at  = search_result.at("verified_at").text
      result.valid        = search_result.at("valid").text
      # result.submitted_at = search_result.at("submitted_at").text
      result
    end
    
    def params
      { :format   => "XML",
        :app_key  => PhishTank.configuration.api_key,
        :url      => @url }
    end
    
    def search_uri
      "http://checkurl.phishtank.com/checkurl/"
    end
    
    def parse_response(body)
      @doc = Nokogiri::XML(body)
    end
  end
end
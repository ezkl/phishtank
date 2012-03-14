require 'ostruct'

module PhishTank
  class FeedData
    attr_reader :file, :doc, :entries
        
    def initialize(data_file_path = nil)
      @file = data_file_path || "#{PhishTank.configuration.temp_directory}/online-valid.xml"
      raise "Data File Not Found!" unless File.exists?(@file)
      
      @doc  = parse_data_file
      @entries = []
      process_data_file
    end
    
    def process_data_file
      @doc.xpath("//entry").each do |entry_item|
        entry = OpenStruct.new
        entry.url = entry_item.at("url").text
        entry.phish_id = entry_item.at("phish_id").text
        entry.phish_detail_url = entry_item.at("phish_detail_url").text
        entry.ip_address = entry_item.at("ip_address").text
        entry.submission_time = entry_item.at("submission_time").text
        entry.verified = entry_item.at("verified").text
        entry.verification_time = entry_item.at("verification_time").text
        entry.online_status = entry_item.at("online").text
        entry.target = entry_item.at("target").text
        @entries.push entry
      end
    end
    
    def parse_data_file
      Nokogiri::XML(File.read(@file))
    end
  end
end
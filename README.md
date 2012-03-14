# PhishTank
This is a Ruby interface to [OpenDNS's PhishTank developer API](http://www.phishtank.com/developer_info.php). The PhishTank dataset contains quite a bit of human-verified and classified phishing data, if you're into that sort of thing.

Tested against Ruby 1.9.2 and 1.9.3 w/ Travis-CI. Current Build Status: [![Build Status](https://secure.travis-ci.org/ezkl/phishtank.png?branch=master)](http://travis-ci.org/ezkl/phishtank)

## Installation
From the Rubygems CLI:

  `gem install phishtank`

or w/ Bundler, add the following to the Gemfile.

  `gem 'phishtank'`

## Usage

    require 'phishtank'
    PhishTank.configure do |c|
      c.api_key = "YOUR_PHISHTANK_API_KEY" #required
      c.temp_directory = "/path/to/temporary/directory" #optional - default: /tmp
      c.etag = "ETag" #optional
    end
    
    PhishTank.update!
    
    data = PhishTank::Data.new
    
    data.entries.first 
    # => #<OpenStruct:0x1021026f8
    #    attr_reader :modifiable = true,
    #    attr_reader :table = {
    #                      :url => "http://www.grovesgas.co.uk/TAMFidelidade/clientetam.htm",
    #                 :phish_id => "1389753",
    #         :phish_detail_url => "http://www.phishtank.com/phish_detail.php?phish_id=1389753",
    #               :ip_address => "209.235.144.9",
    #          :submission_time => "2012-03-13T21:46:39+00:00",
    #                 :verified => "yes",
    #        :verification_time => "2012-03-13T22:51:43+00:00",
    #            :online_status => "yes",
    #                   :target => "TAM Fidelidade"
    #    }
    #>
    
Read specs for more details.

## TODO
You can see and contribute to the list of TODO items in [issues](https://github.com/ezkl/phishtank/issues?sort=created&labels=todo&direction=desc&state=open).

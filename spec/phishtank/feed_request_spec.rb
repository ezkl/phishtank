require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhishTank::FeedRequest do  
  describe "#update?" do
    before(:all) do
      PhishTank.api_key = API_KEY
    end
    let(:update_needed)     { described_class.new("Tue, 12 Mar 2012 22:00:00") }
    let(:no_update_needed)  { described_class.new("Wed, 14 Mar 2012 00:00:00") }
    
    it "should respond true if an update is available", :vcr => { :cassette_name => 'update_needed' } do
      update_needed.update?.should eq true
    end
    
    it "should respond false if an update isn't available", :vcr => { :cassette_name => 'no_update_needed' } do
      no_update_needed.update?.should eq false
    end
  end
  
  describe "#get_update" do
    before(:all) do
      PhishTank.configure do |c|
        c.api_key = API_KEY
        c.temp_directory = fixture_path
      end
      request = described_class.new
      
      if File.exists?(fixture_path + "/online-valid.xml")
        @response = File.read(fixture_path + "/online-valid.xml")
      else
        VCR.use_cassette("get_update") do
          @response = request.get_update
        end
      end
    end
    
    it "should create an XML file in the temporary directory" do
      File.exists?(fixture_path + "/online-valid.xml").should eq true
    end
  end
  
  describe "#update_uri" do
    subject do
      PhishTank.api_key = "12345"
      described_class.new
    end
    
    its(:update_uri) { should eq "http://data.phishtank.com/data/12345/online-valid.xml"}
  end
end
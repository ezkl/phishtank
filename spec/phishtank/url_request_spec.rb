require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhishTank::URLRequest do
  subject do
    PhishTank.configure { |c| c.api_key = API_KEY }
    described_class.new("http://www.google.com/?q=search query")
  end
  
  it "should URI-encode the search URL" do
    subject.url.should eq "http://www.google.com/?q=search%20query"
  end
  
  it "should have a search URI" do
    subject.search_uri.should eq "http://checkurl.phishtank.com/checkurl/"
  end
  
  it "should respond to search" do
    subject.should respond_to(:search)
  end
  
  describe "#search" do
    context "valid search", :vcr => { :cassette_name => "valid search" } do
      subject { described_class.new("http://www.grovesgas.co.uk/TAMFidelidade/clientetam.htm").search }
      it "should return a struct of data" do
        subject.should be_kind_of(OpenStruct)
      end
      
      it "should have a bunch of attributes" do
        subject.url.should eq "http://www.grovesgas.co.uk/TAMFidelidade/clientetam.htm"
        subject.in_database.should eq true
        subject.phish_id.should eq "1389753"
      end
    end
    
    context "invalid search", :vcr => { :cassette_name => "invalid search" } do
      it "should return false" do
        subject.search.should eq false
      end
    end
  end
  
  describe "#params" do
    its(:params)  { should include(:format => "XML") }
    its(:params)  { should include(:app_key => API_KEY)}
    its(:params)  { should include(:url => "http://www.google.com/?q=search%20query") }
  end
end
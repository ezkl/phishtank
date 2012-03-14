require "spec_helper"

describe PhishTank do
  it "should have a BASE_URI" do
    subject::BASE_URI.should eq "http://data.phishtank.com"
  end
  
  it 'should take an API key' do
    subject.api_key = "12345"
    subject.api_key.should eq "12345"
  end
  
  describe "#configure" do
    before(:all) do
      described_class.configure do |c|
        c.api_key = "12345"
        c.temp_directory = "/temporary"
        c.etag = "123456"
      end
    end

    its(:api_key)         { should eq "12345" }
    its(:temp_directory)  { should eq "/temporary" }
    its(:etag)            { should eq "123456" }
  end
  
  it { should respond_to(:update!) }
end
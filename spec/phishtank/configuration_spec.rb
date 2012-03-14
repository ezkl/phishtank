require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhishTank::Configuration do
  describe "defaults" do
    subject { described_class.new }
    
    its(:api_key)        { should eq "" }
    its(:etag)           { should eq nil }
    its(:temp_directory) { should eq "/tmp" }
  end
end
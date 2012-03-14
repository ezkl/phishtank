require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PhishTank::Data do
  context "success" do
    before(:all) do
      PhishTank.configure do |c|
        c.temp_directory = fixture_path
      end
      @data = described_class.new
    end
    
    it "should store the path to the data file at #file" do
      @data.file.should eq fixture_path + '/online-valid.xml'
    end
    
    it "should store the parsed Nokogiri XML document at #doc" do
      @data.doc.should be_kind_of(Nokogiri::XML::Document)
    end
    
    it "should return a list of entries at #entries" do
      @data.entries.should be_kind_of(Array)
      @data.entries.count.should >= 1
    end
    
    context "entry" do
      subject { @data.entries.first }

      its(:url)               { should eq "http://www.grovesgas.co.uk/TAMFidelidade/clientetam.htm" }
      its(:phish_id)          { should eq "1389753" }
      its(:phish_detail_url)  { should eq "http://www.phishtank.com/phish_detail.php?phish_id=1389753" }
      its(:ip_address)        { should eq "209.235.144.9" }
      its(:submission_time)   { should eq "2012-03-13T21:46:39+00:00" }
      its(:verified)          { should eq "yes" }
      its(:verification_time) { should eq "2012-03-13T22:51:43+00:00" }
      its(:online_status)     { should eq "yes" }
      its(:target)            { should eq "TAM Fidelidade" }
    end
    
  end

  context "errors" do
    it "should raise an error unless file exists in temporary directory" do
      PhishTank.configure do |c|
        c.temp_directory = "/tmp"
      end
      
      expect { described_class.new }.to raise_error("Data File Not Found!")
    end
  end  
end
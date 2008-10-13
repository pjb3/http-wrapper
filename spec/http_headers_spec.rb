require "#{File.dirname(__FILE__)}/spec_helper"

describe HttpWrapper::Header do
  before do
    @header = HttpWrapper::Header.new("foo", 1)
  end
  it "should append values" do
    @header << 2
    @header.value.should == [1, 2]
  end
  it "should be able to set values" do
    @header.value = 2
    @header.value.should == 2
  end
end

describe HttpWrapper::Headers do
  before do
    @headers = HttpWrapper::Headers.new
  end
  describe "#merge" do
    it "should replace the values" do
      @headers.add "Host", "www1.example.com"
      @headers.add "Foo", "bar"
      @headers.merge("Host" => "www2.example.com", "User-Agent" => "Whatever")
      @headers["Host"].should == "www2.example.com"
      @headers["User-Agent"].should == "Whatever"
      @headers["Foo"].should == "bar"
    end
  end
  describe "#<<" do
    it "should create a new header if the value doesn't exist" do
      @headers << HttpWrapper::Header.new("Host", "www.example.com")
      @headers["Host"].should == "www.example.com"
    end    
    it "should add the value if the value exists" do
      @headers << HttpWrapper::Header.new("Host", "www1.example.com")
      @headers << HttpWrapper::Header.new("Host", "www2.example.com")
      @headers["Host"].should == ["www1.example.com", "www2.example.com"]
    end    
  end
  describe "#add" do
    it "should create a new header if the value doesn't exist" do
      @headers.add "Host", "www.example.com"
      @headers["Host"].should == "www.example.com"
    end    
    it "should add the value if the value exists" do
      @headers.add "Host", "www1.example.com"
      @headers.add "Host", "www2.example.com"
      @headers["Host"].should == ["www1.example.com", "www2.example.com"]
    end    
  end
  describe "#=" do
    it "should create a new header if the value doesn't exist" do
      @headers["Host"] = "www.example.com"
      @headers["Host"].should == "www.example.com"
    end    
    it "should replace the header if exists" do
      @headers["Host"] = "www1.example.com"
      @headers["Host"] = "www2.example.com"
      @headers["Host"].should == "www2.example.com"
    end    
  end  
  describe "#set" do
    it "should create a new header if the value doesn't exist" do
      @headers.set "Host", "www.example.com"
      @headers["Host"].should == "www.example.com"
    end    
    it "should replace the header if exists" do
      @headers.set "Host", "ww1.example.com"
      @headers.set "Host", "ww2.example.com"
      @headers["Host"].should == "ww2.example.com"
    end    
  end
  describe "A couple of headers" do
    before do
      @headers << HttpWrapper::Header.new("Host", "www1.example.com")
      @headers << HttpWrapper::Header.new("Host", "www2.example.com")
      @headers << HttpWrapper::Header.new("User-Agent", "Ruby 1.8.6/http-wrapper 0.1")
    end
    it "should be enumerable" do
      @headers.map{|e| e}.should == [
        ["Host", ["www1.example.com", "www2.example.com"]], 
        ["User-Agent", "Ruby 1.8.6/http-wrapper 0.1"]
      ] 
    end
    it "should be able to be turned to a string" do
      header = <<EOS
Host: www1.example.com
Host: www2.example.com
User-Agent: Ruby 1.8.6/http-wrapper 0.1
EOS
      @headers.to_s.should == header.chomp
    end
  end  
  
end
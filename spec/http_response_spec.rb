require "#{File.dirname(__FILE__)}/spec_helper"

describe HttpWrapper::Response do
  describe ".parse" do
    before do
      @response_string = <<-STR
HTTP/1.1 301 Moved Permanently 
Location: http://www.google.com/ 
Content-Type: text/html; charset=UTF-8 
Date: Mon, 13 Oct 2008 01:52:06 GMT 
Expires: Wed, 12 Nov 2008 01:52:06 GMT 
Cache-Control: public, max-age=2592000 
Server: gws 
Content-Length: 219 

<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>. 
</BODY></HTML>      
      STR
      @response = HttpWrapper::Response.parse(@response_string)
    end
    it "should parse out the code" do
      @response.code.should == 301
    end
    it "should parse out the message" do
      @response.message.should == "Moved Permanently"
    end
    it "should parse out the headers" do
      @response.headers.to_a.should == [
        ["Location", "http://www.google.com/"],
        ["Content-Type", "text/html; charset=UTF-8"],
        ["Date", "Mon, 13 Oct 2008 01:52:06 GMT"], 
        ["Expires", "Wed, 12 Nov 2008 01:52:06 GMT"], 
        ["Cache-Control", "public, max-age=2592000"], 
        ["Server", "gws"], 
        ["Content-Length", "219"]
      ]
    end
    it "should parse out the body" do
      body = <<-BODY
<HTML><HEAD><meta http-equiv="content-type" content="text/html;charset=utf-8">
<TITLE>301 Moved</TITLE></HEAD><BODY>
<H1>301 Moved</H1>
The document has moved
<A HREF="http://www.google.com/">here</A>. 
</BODY></HTML>      
      BODY
      @response.body.should == body
    end
  end
end
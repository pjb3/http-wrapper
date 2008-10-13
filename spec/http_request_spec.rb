require "#{File.dirname(__FILE__)}/spec_helper"

describe HttpWrapper::Request do
  before do
    @request = HttpWrapper::Request.new("GET", "http://example.com/whatever")
  end
  describe "#process_params" do
    describe "with no body or params" do
      it "should not set the body" do
        @request.send(:process_params)
        @request.body.should be_nil
      end
    end
    describe "a non-get with no body with some params" do
      before do
        @request.method = "POST"
        @request.params["foo"] = "bar"
        @request.params["xyz"] = 8
        @request.send(:process_params)
      end
      it "should not set the body" do
        @request.body.should =~ /\A(foo=bar&xyz=8|xyz=8&foo=bar)\Z/
      end
      it "should not set the body" do
        @request.uri.query.should be_nil
      end
    end
    describe "a get with no body with some params" do
      before do
        @request.method = "GET"
        @request.params["foo"] = "bar"
        @request.params["xyz"] = 8
        @request.send(:process_params)
      end
      it "should not set the body" do
        @request.body.should be_nil
      end
      it "should append the params to the query" do
        @request.uri.query.should =~ /\A(foo=bar&xyz=8|xyz=8&foo=bar)\Z/
      end
    end
    describe "a post with a body and some params" do
      before do
        @request.method = "POST"
        @request.params["foo"] = "bar"
        @request.params["xyz"] = 8
        @request.body = "something"
        @request.send(:process_params)
      end
      it "should not change the body" do
        @request.body.should == "something"
      end
      it "should append the params to the query" do
        @request.uri.query.should =~ /\A(foo=bar&xyz=8|xyz=8&foo=bar)\Z/
      end
    end
    describe "a get with some params" do
      before do
        @request.uri = "http://example.com?foo=1"
        @request.params["foo"] = "bar"
        @request.params["xyz"] = 8
        @request.send(:process_params)
      end
      it "should append the params to the query" do
        @request.uri.query.should =~ /\Afoo=1&(foo=bar&xyz=8|xyz=8&foo=bar)\Z/
      end
    end
    describe "a get and & at the end of the query and some params" do
      before do
        @request.uri = "http://example.com?foo=1&"
        @request.params["foo"] = "bar"
        @request.params["xyz"] = 8
        @request.send(:process_params)
      end
      it "should append the params to the query" do
        @request.uri.query.should =~ /\Afoo=1&(foo=bar&xyz=8|xyz=8&foo=bar)\Z/
      end
    end
  end
  describe "#to_s" do
    before do
      @request = HttpWrapper::Request.new("GET", "http://example.com/whatever")
      @request.params = {"foo" => "bar"}
      @request.headers.add "Accept-Encoding", "gzip,deflate"
    end
    it "should return a string representation of the request" do
      request = <<EOS
GET /whatever?foo=bar HTTP/1.1
Host: example.com
User-Agent: Ruby http-wrapper
Accept-Encoding: gzip,deflate
EOS
      @request.to_s.should == request.chomp
    end
  end
  describe "#escape" do
    it "should encode &" do
      @request.send(:escape, "&").should == "%26"
    end
    it "should encode spaces" do
      @request.send(:escape, "foo bar").should == "foo%20bar"
    end
    it "should encode non-strings" do
      @request.send(:escape, 42).should == "42"
    end
  end
end
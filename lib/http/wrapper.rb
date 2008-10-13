require 'http/wrapper/http'
require 'http/wrapper/headers'
require 'http/wrapper/request'
require 'http/wrapper/response'
# Http.get("http://www.google.com/foo/1", :body => "asdasdas", :params => {"page => 1"}, :headers => {"Content-Type" => "text/html"})
# 
# Http.get("http://www.google.com/foo/1") do |get| 
#   get.params["page"] = 1
#   get.headers["Content-Type"] = "text/html"
# end
# 
# Http.post("http://www.google.com/foo/1", :params => {"page => 1"}, :headers => {"Content-Type" => "text/html"})
# 
# Http.get("http://www.google.com/foo/1", {"page" => "1"}, "Content-Type" => "text/html") do |get|
#   get.params = {}
# end
# 
# 
# Http::Request.new("GET", "http://www.google.com/foo/1")
# Http::Request.new("POST", "http://www.google.com/foo/1")
# 
# puts Http.get.inspect
# 
# get = Http::Request.new
# get.method = "GET"
# get.uri = "http://google.com"
# get.headers = {"Content-Type" => "text/html"}
# response = get.execute(:async => true)
# response.body # implicitly waits
# future = get.execute
# future.callback do 
#   # ...
# end
# future.callback do
#   # more stuff
# end
# future.errback do 
#   # OMGWTFBBQ
# end
# 
# get.execute do |response|
#   
# end
# 
# future = get.execute
# future.wait
# 
# post = Http::Request.new
# post.method = "GET"
# post.uri = "http://google.com"
# post.headers = {"Content-Type" => "text/html"}
# post.body = "asdasdasd"
# 
# 
# 

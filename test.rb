$:.unshift("#{File.dirname(__FILE__)}/lib/")

require 'http/wrapper'
require 'http/wrappers/tcp_socket'

response = HttpWrapper.get("http://www.google.com")
puts "**CODE**"
puts response.code
puts "**MESSAGE**"
puts response.message
puts "**HEADERS**"
puts response.headers.to_s
puts "**BODY**"
puts response.body
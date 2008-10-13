require 'net/http'

module HttpWrapper::NetHttp
  def execute_wrapper(&block)

  end
end
HttpWrapper::Request.send(:include, HttpWrapper::NetHttp)

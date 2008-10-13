require 'rubygems'
require 'curb'

module HttpWrapper::Curb
  def execute_wrapper(&block)
    
  end
end
HttpWrapper::Request.send(:include, HttpWrapper::Curb)

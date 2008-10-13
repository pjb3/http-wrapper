require 'socket'

module HttpWrapper::TCPSocket
  def execute_wrapper(&block)
    socket = TCPSocket.open(uri.host, uri.port)
    socket.write to_s
    response = ""
    while line = socket.gets
      response << line
    end
    socket.close
    HttpWrapper::Response.parse(response)
  end
end
HttpWrapper::Request.send(:include, HttpWrapper::TCPSocket)

class HttpWrapper::Response
  attr_accessor :code, :message, :body, :headers
  def initialize
    @headers = HttpWrapper::Headers.new
    @body = ""
  end
  def self.parse(str)
    response = new
    in_headers = true
    str.each_with_index do |line, i|
      if i == 0 && line =~ /\AHTTP\/(\d\.\d) (\d\d\d) (.*)\Z/
        response.code = $2.to_i
        response.message = $3.strip
      elsif in_headers && line.strip == ""
        in_headers = false
      elsif in_headers && line =~ /\A([\w-]*)\: (.*)\Z/
        response.headers.add $1, $2.strip
      elsif !in_headers
        response.body << line
      end
    end
    response
  end
end
require 'uri'
class HttpWrapper::Request
  DEFAULT_TIMEOUT = 30
  attr_accessor :method, :uri, :headers, :body, :sync, :timeout
  def initialize(_method, _uri, options={}, &block)
    self.method = _method
    self.uri = _uri
    
    self.headers = default_headers
    if new_headers = options.delete(:headers)
      headers.merge(new_headers)
    end
    
    options.each do |k,v|
      send("#{k}=", v)
    end
    self.timeout ||= DEFAULT_TIMEOUT
  end
  
  def prepare
    process_params    
  end
  
  def execute(&block)
    prepare
    execute_wrapper(&block)      
  end

  # def execute_wrapper(&block)
  #   raise "Not Implemented"
  # end
  
  def method=(m)
    @method = m.to_s.upcase
  end
  
  def uri=(u)
    @uri = (URI === u) ? u.clone : URI.parse(u.to_s)      
  end
  
  #If you set the body, then params are tacked on to the url as querystring params
  #Otherwise the body is set to the url encoded params
  def params
    @params ||= {}
  end
  def params=(p)
    @params = p
  end
    
  def to_s
    prepare
    s = "#{method} #{uri.request_uri} HTTP/1.1\n"
    s << headers.to_s
    s << "\n\n"
  end
    
  private
    def process_params
      return if params.empty?
      param_str = params.map{|k,v| "#{k}=#{escape(v)}" }.join("&")
      if body || method.to_s == "GET"
        self.uri.query = case self.uri.query 
                           when nil: param_str
                           when /&$/: "#{self.uri.query}#{param_str}"
                           else "#{self.uri.query}&#{param_str}"
                         end
      else
        self.body = param_str
      end
    end

    def default_headers
      headers = HttpWrapper::Headers.new
      headers.add "Host", uri.host
      headers.add "User-Agent", "Ruby http-wrapper"
      headers
    end

    def escape(v)
      URI.escape(v.to_s, /[^\w]/)
    end  

end  

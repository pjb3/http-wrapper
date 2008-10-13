module HttpWrapper
  def self.get(uri, options={}, &block)
    HttpWrapper::Request.new("GET", uri, options).execute(&block)
  end
  def self.post(uri, options={}, &block)
    HttpWrapper::Request.new("POST", uri, options).execute(&block)
  end
  def self.put(uri, options={}, &block)
    HttpWrapper::Request.new("PUT", uri, options).execute(&block)
  end
  def self.delete(uri, options={}, &block)
    HttpWrapper::Request.new("DELETE", uri, options).execute(&block)
  end
end

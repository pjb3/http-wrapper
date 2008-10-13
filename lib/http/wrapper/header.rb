class HttpWrapper::Header
  attr_accessor :name, :value
  def initialize(name, value)
    @name = name
    @value = value
  end
  def <<(v)
    @value = Array === @value ? @value << v : [@value, v]
  end
end
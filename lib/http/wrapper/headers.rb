require 'http/wrapper/header'
class HttpWrapper::Headers
  include Enumerable

  def initialize(headers={})
    @header_names = []
    @header_map = {}
    merge(headers)
  end

  def merge(headers={})
    headers.each{|k,v| set(k, v) }
  end

  def <<(header)
    if @header_map.has_key?(header.name)
      @header_map[header.name] << header.value
    else
      @header_names << header.name
      @header_map[header.name] = header
    end
  end

  def add(name, value)
    self << HttpWrapper::Header.new(name, value)
  end

  def [](name)
    @header_map.has_key?(name) ? @header_map[name].value : nil
  end

  def []=(name, value)
    @header_map[name] = HttpWrapper::Header.new(name, value)
  end
  
  def set(name, value)
    self[name] = value
  end
  
  def each(&block)
    to_a.each(&block)
  end
  
  def to_a
    @header_names.map{|n| [@header_map[n].name, @header_map[n].value] }
  end
  
  def to_s
    map do |h| 
      if Array === h.last
        h.last.map{|e| "#{h.first}: #{e}" }.join("\n")
      else
        "#{h.first}: #{h.last}"
      end
    end.join("\n")
  end
end

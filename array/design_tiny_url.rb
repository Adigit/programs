class DesignTinyUrl
  MODULO_BASE = 62
  def initialize
    @map = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
  end

  def id2url(id)
    short_url = ""
    while(id != 0)
      short_url += @map[id % MODULO_BASE]
      id /= 62
      p id
    end
    short_url.reverse!
    p "short url > #{short_url}"
    short_url
  end

  def short_url_2_id(url)
    id = 0
    url.each_char do |c|
      if c >= 'a' && c <= 'z'
        id = id * MODULO_BASE + c.ord - 'a'.ord
      elsif c >= 'A' && c <= 'Z'
        id = id * MODULO_BASE + c.ord - 'A'.ord + 26
      elsif c >= '0' && c<= '9'
        id = id * MODULO_BASE + c.ord - '0'.ord + 52
      end
    end
    id
  end
end

obj = DesignTinyUrl.new
p obj.short_url_2_id( obj.id2url(12345))
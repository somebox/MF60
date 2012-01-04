module MF60
  class Helpers
    def self.bytes_formatted(bytes)
      return '-' if bytes <= 0
      units = ['B','K','M','G','T']
      t = 0
      while bytes >= 1024**(t+1)
        t+=1
      end
      n = t>0 ? (bytes/(1024.0**t)) : bytes
      n = n.floor if (n-n.floor)<0.1
      n = n.ceil if (n.ceil-n)<0.1
      fn = (n-n.floor>0) ? sprintf("%.1f", n) : n.ceil
      "#{fn}#{units[t]}"
    end
    
  end
end
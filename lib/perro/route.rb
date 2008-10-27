module Perro
  class Route
    def initialize( r )
      @regexp = Regexp.new( Regexp.escape( r ).gsub(/:[\w]*/ , '(.*?)' )+"(\\?.*)?$" )
      @params_symbols = r.scan(/:(\w+)/).collect{ |m| m[0] }
    end

    def match( string )
      match = string.match( @regexp )
      return nil if match.nil?
      
      params = {}
      @params_symbols.each_index do |i|
        params[@params_symbols[i].to_sym] = match[i+1]
      end
      params
    end
  end
end

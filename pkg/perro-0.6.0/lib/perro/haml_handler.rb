module Perro

  class HAMLHandler < Mongrel::HttpHandler
    def initialize file
      super()
      @file = file
    end

    def process request , response
      filename = request.params['PATH_INFO'].empty? ? "#{@file}/index.haml" : @file+request.params["PATH_INFO"]
      if ( !File.exists?( filename) )
        response.start(404) do |head,out|
          out.write( "404 Error : File #{filename} was not found" )
        end
      else
        response.start(200) do |head,out|
          head['Content-Type'] = 'text/html'
          engine = Haml::Engine.new( open(filename).read )
          out.write( engine.render )
        end
      end
    end
  end

  class Server
    def haml uri , file
      route( :haml , uri , file )
    end
  end

  Server.route_manager( :haml , HAMLHandler )
end

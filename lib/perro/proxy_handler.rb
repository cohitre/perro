module Perro

  class ProxyHandler < Mongrel::HttpHandler
    def initialize url
      super()
      @url = url
    end

    def process request , response
      response.start(200) do |head,out|
        head['Content-Type'] = 'text/html'
        out.write( open(@url + request.params["PATH_INFO"]).read )
      end
    end
  end

  class Server
    def proxy uri , file
      route( :proxy , uri , file )
    end
  end
  Server.route_manager( :proxy , ProxyHandler )
end

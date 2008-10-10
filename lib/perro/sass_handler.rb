require "sass"

module Perro

  class SASSHandler < Mongrel::HttpHandler
    def initialize path
      super()
      @path = path
    end

    def process request , response
      response.start(200) do |head,out|
        head['Content-Type'] = 'text/css'

        engine = Sass::Engine.new( open("#{@path}#{request.params["PATH_INFO"]}").read )

        out.write( engine.render )
      end
    end
  end

  class Server
    def sass uri , file
      route( :sass , uri , file )
    end
  end
  Server.route_manager( :sass , SASSHandler )
end

begin
  require 'action_controller'
  ActionView::Base.helper_modules.each {|m| include m }  
rescue
  puts "It appears that you don't have action_controller."
  puts "`sudo gem install rails` might help you with that."
end

require "mongrel"
require "#{File.expand_path( __FILE__ +"/..")}/perro/route.rb"

module Perro
  VERSION = '0.8.0'

  class StringHandler < Mongrel::HttpHandler
    def initialize
      @routes = []
      @handlers = {}
    end

    def push( route , block)
      r = Route.new( route[:route] )
      @routes.push( route.merge( { :route_object => r } ) )
      @handlers[r] = block
    end

    def find_handler( uri )
      @routes.find{|r| r[:route_object].match(uri)}
    end

    def process request , response
      uri = request.params["PATH_INFO"]

      handler = self.find_handler( uri )

      if ( handler.nil? )
        response.start(404) do |head,out|
          head['Content-Type'] = 'text/html'
          out.write( "404 error" )
        end
      else
        
        route = handler[:route_object]

        form_params = {}
        (request.params["QUERY_STRING"]||"").split("&").each do |d|
          pair = d.split("=")
          form_params.merge!( {pair[0].to_sym => pair[1] })
        end
        
        user_params = route.match( uri ).merge( form_params ).merge({
          :path => request.params["PATH_INFO"]
        })
        puts user_params.inspect
        result = @handlers[route].call( user_params )

        response.start(200) do |head,out|
          head['Content-Type'] = handler[:mime]
          out.write( result.to_s )
        end
      end
    end
  end

  class Server
    attr_reader :path
    
    def initialize port=3000
      @global_handler = StringHandler.new()
      @port = port
    end

    def get route , mime="text/html" , &block
      @global_handler.push( { :route => route , :mime=>mime } , block )
    end
    
    def start
      routes = @global_handler
      port = @port
      config = Mongrel::Configurator.new :host => "0.0.0.0" do
        listener :port => port do
          uri("/" , :handler => routes )
        end
        run
      end
      puts '** Perro Server Started'
      puts '** Woof Woof'
      puts "** Listening to port #{@port}"
      puts '** Use CTRL-C to stop.'

      config.join
    end
  end
end

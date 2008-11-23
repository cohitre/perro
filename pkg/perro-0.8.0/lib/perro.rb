require "mongrel"
require "#{File.expand_path( __FILE__ +"/..")}/perro/route.rb"
require "haml"
require "sass"

module Perro
  VERSION = '0.9.0'

  def use_rails_helpers
    begin
      require 'action_controller'
      ActionView::Base.helper_modules.each {|m| include m }  
    rescue
      puts "It appears that you don't have action_controller."
      puts "`sudo gem install rails` might help you with that."
    end
  end

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

    def static( route , path , mime=:html)
      mimetypes = {
        :html => "text/html" , 
        :javascript => "text/javascript" , 
        :css => "text/css"
      }
      self.get( route , mimetypes[mime] ) do |params|
        open( "#{path}/#{params[:file]}" ).read
      end
    end

    def haml( route , path )
      self.get( route ) do |params|
        if File.exists?( path ) && !File.directory?( path )
          Haml::Engine.new( open( "#{path}" ).read).render
        else
          Haml::Engine.new( open( "#{path}/#{params[:file]}" ).read).render
        end
      end
    end
    
    def sass( route , path )
      self.get( route , "text/css") do |params|
        if File.exists?( path ) && !File.directory?( path )
          Sass::Engine.new( open( "#{path}" ).read).render
        else
          Sass::Engine.new( open( "#{path}/#{params[:file]}" ).read).render
        end
      end
    end


    def get route , mime="text/html" , &block
      @global_handler.push( { :route => route , :mime=>mime } , block )
    end
    
    def run
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

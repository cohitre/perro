begin
  require 'action_controller'
rescue
  puts "It appears that you don't have action_controller."
  puts "`sudo gem install rails` might help you with that."
end

require "open-uri"
require "mongrel"

ActionView::Base.helper_modules.each {|m| include m }

module Perro
  VERSION = '0.6.0'

  class Server
    attr_reader :routes
    @@route_keys = {}


    def self.route_manager key , handler
      @@route_keys[key] = handler
    end

    def initialize port=3000
      @routes_manager = {}
      @port = port
    end

    def route key , uri , file
      @routes_manager[key] ||= []
      r = { :route => uri , :resource => file }
      @routes_manager[key].push( r )
    end

    def static uri , file
      route( :static , uri , file )
    end

    def start
      routes = @routes_manager
      port = @port
      config = Mongrel::Configurator.new :host => "0.0.0.0" do
        listener :port => port do
          routes.each do |k,v|
            v.each do |r|
              uri( r[:route] , :handler => @@route_keys[k].new( r[:resource]) )
            end
          end
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

  Server.route_manager( :static , Mongrel::DirHandler )
end

require "#{File.expand_path( __FILE__+"/.." )}/perro/haml_handler.rb"
require "#{File.expand_path( __FILE__+"/.." )}/perro/proxy_handler.rb"
require "#{File.expand_path( __FILE__+"/.." )}/perro/sass_handler.rb"

require "rubygems"
require "lib/perro"
require "sass"
require "open-uri"

HOME_FOLDER = File.expand_path( "~" )

server = Perro::Server.new(3000)

server.static( "/javascripts/:file" , "#{HOME_FOLDER}/dev/libs/js"  , :javascript )



server.haml( "/" , "#{File.expand_path( File.dirname( __FILE__) )}/index.haml" )



server.get "/stylesheets/:file.css" do |params|
  Sass::Engine.new( open("#{HOME_FOLDER}#{params[:file]}.sass").read )
end

server.get "/proxy/:uri" do |params|
  open( "http://cohitre.com/#{params[:uri]}" ).read
end


server.haml( "/:file" , "#{File.expand_path( File.dirname(__FILE__) )}" )

server.start
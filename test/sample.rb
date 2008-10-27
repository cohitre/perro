require "rubygems"
require "perro"
require "sass"
require "open-uri"

HOME_FOLDER = File.expand_path( "~" )

server = Perro::Server.new(3000)

server.get "/javascripts/:file" do |params|
  open( "#{HOME_FOLDER}/libs/javascript#{params[:file]}" ).read
end

server.get "/stylesheets/:file.css" do |params|
  Sass::Engine.new( open("#{HOME_FOLDER}#{params[:file]}.sass").read )
end

server.get "/proxy/:uri" do |params|
  open( "http://cohitre.com/#{params[:uri]}" ).read
end

server.start
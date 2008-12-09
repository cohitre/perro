require "rubygems"
require "perro"

PROJECT_HOME = File.expand_path(__FILE__+"/..")

s = Perro::Server.new( 3000 )

s.get("/javascripts/:file.js" , :javascript )  { |p| open("#{PROJECT_HOME}/javascripts/#{p[:file]}.js").read }
s.get("/stylesheets/:file.css" , :stylesheet ) { |p| open("#{PROJECT_HOME}/stylesheets/#{p[:file]}.css").read }
s.haml("/" , "#{PROJECT_HOME}/index.haml")
s.start
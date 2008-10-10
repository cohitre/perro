= perro

http://code.cohitre.com

== DESCRIPTION:

Perro is a light server built on top of mongrel that helps at least 
one developer be happy. If it had been designed as production server 
it would have a cooler name. Like "Dinosaur" or "Freckle".

The Internet is a global system of interconnected computer networks. 
Developer creates files that are served through this global system. 
Developer may be tempted to develop such files by creating a folder, 
moving the files to such folder, double clicking them and watching 
what happens on the browser whose address bar reads 
"file:///Users/cohitre/development/my-project/index.html".

Perro helps developer be happy by helping overcome temptation.

== FEATURES/PROBLEMS:

Developer wants file "guaca.haml" served on route "mayo". Perro can 
help with that if asked nicely.

== SYNOPSIS:

HOME_FOLDER = File.expand_path( "~" )

server = Perro::Server.new(3000)
server.static( "/javascripts" , "#{HOME_FOLDER}/libs/javascript")
server.sass( "/stylesheets" , "#{HOME_FOLDER}/libs/sass")
server.proxy( "/service" , "http://example.com" )
server.haml( "/" , "#{File.expand_path(".")}/" )
server.start

== REQUIREMENTS:

mongrel
haml


== INSTALL:

"sudo gem install perro" may work...

== LICENSE:

(The MIT License)

Copyright (c) 2008 Carlos Rodriguez

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

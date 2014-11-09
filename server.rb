require 'socket'

server = TCPServer.open(2000)       #listens on port 2000
loop {
	client = server.accept            #wait for client to connect
	client.puts(Time.now.ctime)
	client.puts "Closing the connection. Bye!"
	client.close
}
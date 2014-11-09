require 'socket'

server = TCPServer.open(2000)       #listens on port 2000
loop {
	client = server.accept            #wait for client to connect
	request = client.gets.split(" ")
  
  puts request

	if request[0] == "GET"
		resource = request[1]
		version = request[2]
	end
  
  if Dir.entries(".").include?(resource)
  	response = "#{version} 200 OK\r\n\r\n"
  	header = "Server: JKisAwesome2.0\r\n\r\n"
  	body = File.open(resource) { |f| f.read }
  else
  	response = "#{version} 404 Not Found\r\n\r\n"
  end

  puts "received request: #{request[0..2].join(" ")}"
  puts "received header: #{request[3..-1].join(" ")}"

  client.print response
  client.print header
  client.print body

	client.puts "Closing the connection. Bye!"
	client.close
}
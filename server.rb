require 'socket'

server = TCPServer.open(2000)       #listens on port 2000
loop {
	client = server.accept            #wait for client to connect
	
	headers = []
	begin
	  line = client.gets
	  headers << line
	end until line =~ /^\s*$/   #line begins and ends with one or more whitespace characters

	request = headers[0].split(" ")

	if request[0] == "GET"
		resource = request[1]
		version = request[2]
	  if File.exist?(resource)
    	response = "#{version} 200 OK\r\nServer: JKisAwesome2.0\r\n\r\n"
    	body = File.open(resource) { |f| f.read }
    else
    	response = "#{version} 404 Not Found\r\n\r\n"
    end
  end

  puts "received request: #{headers[0..2].join(" ")}"
  puts "#{headers[3..(-1)].join(" ")}"
  
  client.print response
  client.print body unless body.nil?

  client.puts "Closing the connection. Bye!"
	client.close
}
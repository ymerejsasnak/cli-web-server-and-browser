require 'socket'
require 'json'


class Server
  attr_reader :server

  def initialize
  	@server = TCPServer.open(2000)       #listens on port 2000
  end
  
  def run
    loop do 
    	client = server.accept            #wait for client to connect
  	
    	headers = get_headers(client)
    	
    	display_request(client, headers)
    	 
      request = headers[0].split(" ") 
      
      response = parse_request(client, request)
     
      send_response(client, response)
    end
  end

  #######
  private
  #######

  def get_headers(client)
  	headers = []
  	begin
      line = client.gets
      headers << line
    end until line =~ /^\s*$/   #line begins and ends with one or more whitespace characters 
    return headers
  end
  
  def display_request(client, headers)
    puts
    puts "received request: #{headers[0..2].join(" ")}"
    puts "#{headers[3..(-1)].join(" ")}"
  end

  def parse_request(client, request)
  	method = request[0]
    resource = request[1]
	  version = request[2]
    if method == "GET"
	   	if File.exist?(resource)
       	body = File.open(resource) { |f| f.read }
       	return "#{version} 200 OK\r\nServer: JKisAwesome2.0\r\nDate: #{Time.now}\r\nContent-Length: #{body.size}\r\n\r\n" + body
      else
       	return "#{version} 404 Not Found\r\n\r\n"
      end
    elsif method == "POST"
    	params = JSON.parse(client.gets)
    	body = File.open("thanks.html") { |f| f.read }
      body.gsub!("<%= yield %>", "<li>Name: #{params['user']['name']}</li><li>Email: #{params['user']['email']}</li>")
      return "#{version} 200 OK\r\nServer: JKisAwesome2.0\r\nDate: #{Time.now}\r\nContent-Length: #{body.size}\r\n\r\n" + body     
    else
    	return "#{version} 400 Bad Request\r\n\r\n"
    end
  end

  def send_response(client, response)
    client.print response
    client.close
  end

end



server = Server.new
server.run
require 'socket'
require 'json'

class Browser
	attr_reader :host, :port
	  
  def initialize
	  @host = "localhost"
    @port = 2000
  end

  def send_request(method, path, post_request="")
    socket = TCPSocket.open(host, port)
    content_string = "Content-Length: #{post_request.size}" unless post_request == ""
    request = "#{method} #{path} HTTP/1.0\r\nFrom: jk@mail.com\r\nDate: #{Time.now}\r\n#{content_string}\r\n\r\n#{post_request}\r\n"
    socket.print(request)
    return socket.read.split("\r\n\r\n")
  end

  def display_response(response)
    headers, body = response[0], response[1]
    puts
    puts
    puts headers
    puts
    puts
    puts body
    puts
    puts
  end

  def get_user_input
  	puts
  	puts "Type GET followed by the name of the resource to GET said resource."
  	puts "Type POST followed by your -name- and -email address- to POST that information."
  	puts
  	input = gets.chomp.split(" ")
  	method = input[0]
  	if method == "GET"
  		path = input[1]
  		display_response(send_request(method, path))
  	elsif method == "POST"
      path = "./"
      name = input[1]
      email = input[2]
      post_request = {:user => {:name => "#{name}", :email => "#{email}"}}.to_json
      display_response(send_request(method, path, post_request))
  	end
  end
end



browser = Browser.new
browser.get_user_input


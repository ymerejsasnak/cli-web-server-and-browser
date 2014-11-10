require 'socket'

class Browser
	attr_reader :host, :port, :method, :path, :request
	  
  def initialize
	  @host = "localhost"
    @port = 2000
    @method = ""
    @path = ""
  end

  def send_request
    socket = TCPSocket.open(host, port)
    request = "#{method} #{path} HTTP/1.0\r\nFrom: jk@mail.com\r\nUser-Agent: JKbrowser\r\nDate: #{Time.now}\r\n\r\n"
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
  	#puts  "Type POST .. .. .. . . .(to be done..)"
  	puts
  	input = gets.chomp.split(" ")
  	@method = input[0]
  	@path = input[1]
  end
end



browser = Browser.new
browser.get_user_input
browser.display_response(browser.send_request)

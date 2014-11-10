require 'socket'

class Browser
	attr_reader :host, :port, :path, :request
	attr_accessor :response
  
  def initialize
	  @host = "localhost"
    @port = 2000
    @path = (ARGV[0]) #just type the file to find from the command line
    @request = "GET #{path} HTTP/1.0\r\nFrom: jk@mail.com\r\nUser-Agent: JKbrowser\r\nDate: #{Time.now}\r\n\r\n"
  end

  def send_request
    socket = TCPSocket.open(host, port)
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

end



browser = Browser.new
browser.display_response(browser.send_request)

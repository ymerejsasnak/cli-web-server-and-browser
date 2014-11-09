require 'socket'

host = "localhost"
port = 2000
path = "index.html"

request = "GET #{path} HTTP/1.0\r\n\r\n"
header = "From: jk@mail.com  User-Agent: JKbrowser\r\n\r\n"

puts request + header

socket = TCPSocket.open(host, port)
socket.print(request + header)
response = socket.read

response, headers, body = response.split("\r\n\r\n", 3)
puts response
puts headers
puts body
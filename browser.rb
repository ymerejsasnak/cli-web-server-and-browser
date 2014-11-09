require 'socket'

host = "localhost"
port = 2000
path = "index.html"

request = "GET #{path} HTTP/1.0\r\nFrom: jk@mail.com\r\nUser-Agent: JKbrowser\r\n\r\n"

socket = TCPSocket.open(host, port)
socket.print(request)
response = socket.read

headers, body = response.split("\r\n\r\n", 2)
puts headers
puts body
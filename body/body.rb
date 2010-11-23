require 'socket'
require 'shared/pgbt'

    
# This lives in the body and sends status to the brain
class TCPBrainConnection
  include Socket::Constants
  
  def initialize
    @socket = Socket.new(AF_INET, SOCK_STREAM, 0)
    @socket.setsockopt(Socket::SOL_SOCKET, Socket::SO_REUSEADDR, true)
    sockaddr = Socket.pack_sockaddr_in(PigPort, $localhost)
    @socket.bind(sockaddr)
    @socket.listen(5)

    puts "Waiting for the brain..."
    @brain, brain_addr = @socket.accept
    brain_port, brain_ip = Socket.unpack_sockaddr_in(brain_addr)

    puts "I has a brain from #{brain_ip}!"
    
    @brain.puts "hello brain!"
  end
  
  def send_status(status)
    @brain.puts status
  end

  def recv_cmd
    @brain.readline.chomp
  end  
end

b = TCPBrainConnection.new

loop do
  cmd = b.recv_cmd
  if cmd == 'close' then
    b.send_status("byebye :-(")
    exit
  else
    puts "CONFUSED!!!"
  end
end



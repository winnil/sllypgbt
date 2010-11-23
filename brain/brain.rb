require 'socket'
require 'shared/pgbt'

# This lives in the brain and sends commands to the body
class TCPBodyConnection
  include Socket::Constants
  
  def initialize(host = $localhost)
    @socket = Socket.new(AF_INET, SOCK_STREAM, 0)
    sockaddr = Socket.pack_sockaddr_in(PigPort, host)
    
    puts "Connecting to the body..."
    @socket.connect(sockaddr)

    puts "I has a body!"
  end
  
  def send_cmd(cmd)
    @socket.puts cmd
  end

  def recv_status
    @socket.readline.chomp
  end  
end

def pig_console
  @body = TCPBodyConnection.new
  
  loop do
    #puts "Body says: '#{@body.recv_status}'"
    got_cmd = gets.chomp
    cmd = convert_cmd(got_cmd)
    #got_num_parms = gets.chomp
    command = [1, cmd, 0]
    @body.send_cmd command.pack("ccv")
    if got_cmd == 'close'
      exit
    end
  end
end

pig_console


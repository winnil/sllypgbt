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
    
  def eval_cmd(cmd_code)
    table = {
      P_cmd_close => :close,
      P_cmd_oink  => :oink,
      P_cmd_walk  => :walk,
      P_cmd_sleep => :sleep,
      P_cmd_eat   => :eat,
      P_cmd_roll  => :roll,
      P_cmd_grunt => :grunt,
    }
    
    map = table[cmd_code]
    if (map)
      return map
    else 
      raise 'go away, i hate you' 
    end
  end
end

class Body
  def initialize(conn_type=TCPBrainConnection)
    @conn = conn_type.new    
  end
  
  def send_status(status)
    @conn.send_status status
  end
  
  def process_next_cmd
    cmd = @conn.recv_cmd.unpack('ccv')

    if cmd[0] == PMF_cmd
      case @conn.eval_cmd(cmd[1])
      when :close 
        exit
      when :oink
        system "open rsc/tstPg.jpg"
      when :walk
        direction = 'unkown'
        if (rand(1) == 0)
          direction = 'forward'
        else
          direction = 'backward'
        end
        puts "walking for #{rand(50)} steps #{direction}"
      when :grunt
        puts "grunt"
      when :roll
        puts "rolling to the sound of music!!! lalalalala! oink."
        system "open rsc/tstOnk.mp3"
      else
        puts "CONFUSED!!!"
      end
    end
    
  end
end

def test_pig
  b = Body.new

  loop do
    b.process_next_cmd
  end
end



PigPort = 10001

@mac_os_flag = RUBY_PLATFORM.downcase.include?("darwin") 

$localhost = 'localhost'
if @mac_os_flag
  $localhost = '127.0.0.1'
end

# types of messages
PMF_cmd    = 1
PMF_status = 2

# types of commands
P_cmd_walk    = 1
P_cmd_eat     = 2
P_cmd_sleep   = 3
P_cmd_close   = 4
P_cmd_roll    = 5
P_cmd_oink    = 6
P_cmd_grunt   = 7

def convert_cmd(cmd)
  table = {
    'close' => P_cmd_close
  }
  
  map = table[cmd]
  if (map)
    return map
  else 
    raise 'go away, i hate you' 
  end
end

def convert_status(status)
  #TODO
end
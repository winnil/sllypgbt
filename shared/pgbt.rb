PigPort = 10001

@mac_os_flag = RUBY_PLATFORM.downcase.include?("darwin") 

$localhost = 'localhost'
if @mac_os_flag
  $localhost = '127.0.0.1'
end

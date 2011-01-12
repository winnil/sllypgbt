class Environment
  def initialize(w, h)
    # TODO: make more shapes
    @width  = w
    @height = h
    @pig = Body.new
    @pig_loc = { :x => w/2, :y => h/2 }
  end
  
  def next_step
    @pig_loc[:x] += 1
    
    # TODO: has pig eaten??
    
    @pig.send_status "Pig hit wall! Am at (#{pig_loc[:x]}, #{pig_loc[:y]})"
    @pig.process_next_cmd
  end
end

def simulate 
  loop do
    next_step
  end
end

class Environment
  def initialize(w, h)
    # TODO: make more shapes
    @width  = w
    @height = h
    @body = nil
    @body_loc = { :x => w/2, :y => h/2 }
  end
  
  def put_body(b)
    @body = b
  end
  
  def next_step    
    @body_loc[:x] += @body.x_dir
    @body_loc[:y] += @body.y_dir
    
    # TODO: has pig eaten??
    
    @body.send_status "Pig hit wall! Am at (#{@body_loc[:x]}, #{@body_loc[:y]})"
    @body.process_next_cmd
  end

  def simulate 
    @body.wait_for_brain
    
    loop do
      next_step
    end
  end

end

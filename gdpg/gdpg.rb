class God
  def initialise
    @creations = {}
  end

  def create(name, thing)
    @creations[name] = thing.new
  end
  
  def create_env
    Process::fork do
      puts "hello I am a new process!"
    end
    puts "hello I am still the old process :-("
  end
  
  def create_world
    @env = Environment.new(10,10)
    @body = Body.new
    
    @env.put_body @body
  end
  
  def run_world
    Process::fork do
      # Start brain
      puts "about to start the brain!"
      pig_console
    end
    @env.simulate
  end
  
end


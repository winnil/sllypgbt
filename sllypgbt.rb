require 'environment/environment'
require 'body/body'
require 'brain/brain'
require 'gdpg/gdpg'

g = God.new
  g.create_world
  g.run_world

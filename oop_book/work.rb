module Foliage
  def trees
    puts "We planted a tree!"
  end
end

class Creation
  include Foliage
end

the_world = Creation.new
the_world.trees
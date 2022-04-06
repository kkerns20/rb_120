module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

# How do you find where Ruby will look for a method
# whne that method is called?
# How can you find an object's ancestors?

# We could call `.ancestors` on an objects class to see the method lookup path
# The lookup chain for Orange and HotSauce would be:
p Orange.ancestors
# => [Orange, Taste, Object, Kernel, BasicObject]
p HotSauce.ancestors
# => [HotSauce, Taste, Object, Kernel, BasicObject]

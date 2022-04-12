# make flip_switch and setter method `switch=` private methods

class Machine
  def start
    flip_switch(:on)    # self.flip_switch(:on) is okay in Ruby 2.7 or higher
  end
  
  def stop
    flip_switch(:off)   # self.flip_switch(:on) is okay in Ruby 2.7 or higher
  end

  def display_switch_state
    puts "The switch is currently #{switch}!"
  end
  
  private

  attr_accessor :switch

  def flip_switch(desired_state)
    self.switch = desired_state
  end
end

# Further exploation:
# add a private getter and ad a method to Machine that shows
# how to use that method

kreischer = Machine.new
kreischer.start
kreischer.display_switch_state
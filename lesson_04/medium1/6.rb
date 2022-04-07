#  Given two separate classes, what is the difference in how it's executed

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

# AND

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

=begin
In the both, we have instance variable template and getter and setter methods

In the first, we reassign the instance variable directly in `create_template`, but
in the second, we utilize the setter method to reassign the instance variable

In show_template in the first, we access the getteer method within the body of show template,
but in the second, we access the instance variable with self.

The first will reassign and get the instance variable. The second will set and 
get the instance variable.

Both are fine, but it's better to "Avoid self where not required"

Getter methods don't require self, but setters do
=end
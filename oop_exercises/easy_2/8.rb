# Identify and fix the following code

class Expander
  def initialize(string)
    @string = string
  end

  def to_s
    # can't use `self` with the private instance method expand
    expand(3) # instead of self.expand(3)
  end

  private

  def expand(n)
    @string * n
  end
end

expander = Expander.new('xyz')
puts expander
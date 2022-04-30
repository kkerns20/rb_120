# this will not work
class Contact
  attr_accessor :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def change_number(n)
    number = n                  # Ruby thinks we are initializing local variable
  end
end

kurt = Contact.new('Kurt', '234-2107')
kurt.number                    # => 234-2107

kurt.change_number('867-5309')
kurt.number                    # => 234-2107

# this will work
class Contact
  attr_accessor :name, :number

  def initialize(name, number)
    @name = name
    @number = number
  end

  def change_number(n)
    self.number = n                  # call setter method using self.
  end
end

kurt = Contact.new('Kurt', '234-2107')
p kurt.number                    # => 234-2107

kurt.change_number('789-4039')
p kurt.number                    # => 789-4039
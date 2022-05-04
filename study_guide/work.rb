class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def change_name(new_name)
    self.name = new_name
  end
end

bill = Person.new('William')
p bill.name                   # => "William"
bill.change_name('Bill')
p bill.name                   # => "Bill"
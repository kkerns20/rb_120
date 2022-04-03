# Complete the program so that it produces the expected output:
# John Doe
# Jane Smith

class Person
  def initialize(first_name, last_name)
    @first_name = cap_name(first_name)
    @last_name = cap_name(last_name)
  end

  def first_name=(name)
    @first_name = cap_name(name)
  end

  def last_name=(name)
    @last_name = cap_name(name)
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end

  private

  def cap_name(name)
    name.capitalize
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person
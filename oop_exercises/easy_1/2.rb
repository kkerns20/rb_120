# What does the code print?
# Fix this class so that there are no surprises waiting for unsuspecting deverloper
class Pet
  attr_reader :name

  def initialize(name)
    @name = name.to_s # String#to_s returns self
  end

  def to_s
    # @name.upcase!
    # "My name is #{@name}."
    "My name is #{@name.upcase}."    
  end
end

name = 'Fluffy'
fluffy = Pet.new(name)
puts fluffy.name      # Fluffy
puts fluffy           # My name is FLUFFY.           
puts fluffy.name      # FLUFFY
puts name             # FLUFFY

# What would happen with the below code?
# String#to_s returns self. Integer#to_s returns a new String object
name = 42
fluffy = Pet.new(name)
name += 1
puts fluffy.name      # 42
puts fluffy           # 42
puts fluffy.name      # 42
puts name             # 43 - name and @name never referenced the same object in memory
=begin
1.
  - Create a subclass from Dog called Bulldog
  - override the swim method and return "can't swim"
2.
  - Create a new class called Cat
  - Cat can do everything that Dog can except swim and fetch
3. 
  - Draw a class hierarchy diagram of the classes from step 2
                            Pet(run, jump)
          Dog(speak, fetch, swim)     Cat(speak)
            Bulldog(swim)
4. What is the *method lookup path* and how is it important?
    - Ruby will start with the innermost class and gradulally work its way
    - higher up to BasicObject. This is important because this is the path a 
    - method call takes as it tried to find the class that holds the method
    - If if finds none, it will throw a NoMethodError. Lower level methods with
    - and can override a method higher up the class food chain, as seen by to_s
LS Response:
The method lookup path is the order in which Ruby will traverse the class hierarchy 
to look for methods to invoke. For example, say you have a Bulldog object called bud 
and you call: bud.swim. Ruby will first look for a method called swim in the 
Bulldog class, then traverse up the chain of super-classes; it will invoke the 
first method called swim and stop its traversal.

In our simple class hierarchy, it's pretty straight forward. Things can quickly 
get complicated in larger libraries or frameworks. To see the method lookup path, 
we can use the .ancestors class method.

Bulldog.ancestors       # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]

Note that this method returns an array, and that all classes sub-class from Object. 
Don't worry about Kernel or BasicObject for now.
=end

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
  
  def fetch
    'fetching!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

karl = Bulldog.new
puts karl.speak           # => "bark!"
puts karl.swim            # => "can't swim!"

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
# pete.speak                 # => NoMethodError

puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
# kitty.fetch                # => NoMethodError

puts dave.speak              # => "bark!"

puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"
puts 
puts "-----Method Lookup Path-----"
puts pete.class.ancestors
puts
puts kitty.class.ancestors
puts
puts bud.class.ancestors
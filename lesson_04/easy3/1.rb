class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# What happens in each of the following?
hello = Hello.new
hello.hi
# Hello is printed to the terminal
hello = Hello.new
hello.bye
# undefined method error, since `Hello` doesn't have access to that method
hello = Hello.new
hello.greet
# ArgumentError reporting a wrong number of arguments, expecting 1 and given none
hello = Hello.new
hello.greet("Goodbye")
# Goodbye is printed to the terminal
Hello.hi
# `hi` is not a class method, so it raises an exception of undefined method `hi`
# `hi` is an instance method and we try to call it on the `Hello` class rather than an instance of the class.
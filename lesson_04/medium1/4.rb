# create class `Greeting` with a single instance method `greet`
# greet take a string argument and prints that to the terminal

# create two other classes that are derived from Greeting
# Hello - have a method hi that take no arguments and prints HEllo
# Goodbye - method bye that says Goodbye
# no puts in subclass, makeuse of the greet method from Greeting

class Greeting
  def greet(str)
    puts str
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
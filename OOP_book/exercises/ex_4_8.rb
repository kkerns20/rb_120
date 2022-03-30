# 8. 
# Given the following code...
bob = Person.new
bob.hi
# And the corresponding error message...
# NoMethodError: private method `hi' called for #<Person:0x007ff61dbb79f0>
# from (irb):8
# from /usr/local/rvm/rubies/ruby-2.0.0-rc2/bin/irb:16:in `<main>'

# What is the problem and how do you fix it?

=begin
based on the error message, it appears that we are trying
 to access the Person#hi method that is set to private. If the 
 method were brought above the private method call then it would be
 accessible.
=end
# Complete the program so that it produces the expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  attr_accessor :author, :title   # add instance variables, getter and setter methods

  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin
What do you think of this way of creating and initializing Book objects? (The two steps are separate.) 
  - This way is concise, but you will need to initialize each state of the instance variables independently.
Would it be better to create and initialize at the same time like in the previous exercise? 
  - Again, it would depend on the user of the program and what interface they would prefer
  - Initializing with arguments or setting each creating and then intializing

What potential problems, if any, are introduced by separating the steps?
  - The problem I would see is not knowing exactly what instance variable I can intiialize
=end
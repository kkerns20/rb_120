# Complete the program so that it produces the expected output:
# The author of "Snow Crash" is Neil Stephenson.
# book = "Snow Crash", by Neil Stephenson.

class Book
  # attr_reader :author, :title

  def initialize(author, title)
    @author = author
    @title = title
  end

  def title
    @title
  end
  
  def author
    @author
  end

  def to_s
    %("#{title}", by #{@author})
  end
end

book = Book.new("Neil Stephenson", "Snow Crash")
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

=begin
What are the differences between attr_reader, attr_writer, attr_accessor?
attr_reader creates instances variables and two getter methods
attr_setter creates instances variables and two setter methods
attr_accessor creates instance variables and both getter/setter methods

Why attr_reader instead of writer or accessor?
We just want to get the state of the instance variables.

Would it be okay to use one of the others?
attr_accessor would still allow the code to run, but it would
leave the program vulnerable to overwriting the state of @author and @title
Depends on if you want to allow that or not

actually defining the getter methods would also allow the code to run
This could be advantageous if a developer just needed to see what the Book class is necessary for
=end
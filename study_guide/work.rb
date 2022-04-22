class Library
  attr_accessor :books

  def initialize
    @books = []
  end

  def <<(book)
    books.push(book)
  end

  def checkout_book(title, author)
    book_to_checkout = Book.new(title, author)
    if books.include?(book_to_checkout)
      books.delete(book_to_checkout)
    else
      puts "The library does not have that book"
    end
  end
end

class Book
  attr_reader :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_s
    "#{title} by #{author}"
  end

  def ==(other_book)
    title == other_book.title &&
    author == other_book.author
  end
end

lib = Library.new

lib << Book.new('Fight Club', 'Chuck Palahniuk')
lib<<(Book.new('The Fellowship of the Ring', 'J.R.R. Tolkien'))
lib << Book.new('Skin Game', 'Jim Butcher')

lib.books.each { |book| puts book }
  # => Fight Club by Chuck Palahniuk
  # => The Fellowship of the Ring by J.R.R. Tolkien
  # => Skin Game by Jim Butcher

lib.checkout_book('Fight Club', 'Chuck Palahniuk')
  # deletes the Fight Club book object from @books and returns it

lib.books.each { |book| puts book }
  # => The Fellowship of the Ring by J.R.R. Tolkien
  # => Skin Game by Jim Butcher

lib.checkout_book('Storm Front', 'Jim Butcher')
  # => The library does not have that book
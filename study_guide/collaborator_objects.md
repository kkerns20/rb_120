# Collaborator Objects #

**Collaborator object**
: an object that is stored as a *state*(i.e. within an instance variable) within another object. They are called *collaborators* because they work in conjunction with the class they are associated with.

Collaborator objects are usually *custon* objects(i.e. defined by programmer and not built into Ruby). Technically, a string or other built in object type that saves as a value in an instance variable would still be a collaborator object but we don't really tend to think of them that way

Collaborator object *represent the connections between various actors in the program*. When thinking about how to stucture various classes, objects, and all the ways in which they might connect, thing about:

- What collaborators will a custom class need?
- Do the associations between a custom class and its collaborators make sense?
- What makes sense here technically?
- What makes sense here with respect to modeling the problem we are attempting to solve?

At the end of the day, collaborator object allow us to chop up and modularize the problem domain into cohesive pieces.

## Example 1 ##

A `Library` is a class representing a collection of `Book` objects. This is a 'has-a' relationship.

```ruby
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
```

First, we initialize the `Library` object. When this object is instantiated, the `@books` instance variable is initialized as wella nd assigned to an empty array. We are going to use the array as a way to facilitate our collection implementation, so that teh `Library` class can internally rely on the `Array` interface to manipulate teh collection of `Book` objects. Technically, the array here would be a collaborator object; however, the relationship between `Array` and `Library` is not really meaningful in terms of the program design.

Next, we add three instances of `Book` to the `Library` object. We've defined an `<<` method in `Library to facilitate the addition of each`Book` object to the `@books` array such that we can utilize Ruby's syntactical sugar and not really worry about the internal mechanics of how each `Book` is getting added to teh `Library` instance. This is an example of [encapsulation](./poly_encaps.md).

We can call the `Array#each` method on the value returned by the getter method `books` in order to output each `Book` object as a string. Doing so shows us that each `Book` instance has indeed been added to our `Library` collection object.

The `Book` instances here are what we are concerned with when we say *collaborator objects.* We consider these to be collaborators because they are separate objects with a separate interface that has been added to an attribute of `Library`. Further, the `Book` interface interacts meaningfully with the `Library` implementation, allowing us to access that interface without necessarily needing to know about it through our manipulations of the `Library` instance outside the class.

Next, we call the `checkout_book` method and pass it the arguments `'Fight Club'` and `'Chuck Palahniuk'`. Within the `checkout_book` implementation we perhaps have our most interesting interation between `Library` and `Book`. We know we are searching through an array of `Book` objects, so first we instantiate a new `Book` with arguments given. Then the method checks to see if the `Library` has the book to checkout (using `Array#include?`). If it does, it removes that book object (which we can do having defined a custom `Book#==` method) and returns it. If the book is not found, the method will output a message to the user saying that the library does not have that particular book.

In this case, the `Book` with the title `'Fight Club'` is found, remofved, and returned. We can verify this by again outputting all the books in the `Library` by calling `each` on the value returned by `books`. At this point, this will only output tow books, *The Fellowship of the Ring* and *Skin Game*.

Finally, we test out our guard clause by trying to checkout a book the library does not have. `checkout_book` executes as expected and the stirng `'The library does not have that book'` is output.

We say that the relationship between `Book` and `Library` here is on of *collaboration* because a library ***has*** books. Which books the library contains and what they are called is an aspect of its *state*. Therefore, the relationship of inheritance would not be appropriate here.

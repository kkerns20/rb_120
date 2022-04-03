class Flight
  attr_accessor :database_handle

  def initialize(flight_number)
    @database_handle = Database.init
    @flight_number = flight_number
  end
end

=begin
There is nothing technically incorrect about this class, 
but the definition may lead to problems in the future. 
How can this class be fixed to be resistant to future problems?

Delete line 2. This is providing easy access to the `@database_handle`
instance varibale, which is almost certainly an implementation detail.
Users of this class should have no need for it, so they wouldn't need access.

What can go wrong if we don't change things? 
First off, by making access to @database_handle easy, someone may use it in real code. 
And once that database handle is being used in real code, 
future modifications to the class may break that code. 
You may even be prevented from modifying your class at all if the dependent code is of greater concern.
=end
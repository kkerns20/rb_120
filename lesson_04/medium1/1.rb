class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

# Does `balance` in `positive_balance?` method need an @?
bank = BankAccount.new(3200)
p bank.positive_balance?

# Because of the `attr_reader` for the balance instance variable,
# we do not need an `@` to reference it. Ruby automatically creates
# a method called `balance` that returns the value of `@balance`
# The body of `positive_balance?` is calling the `balance` method in this case
class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

# What would be wrong with fixing it with attr_accessor or 
# referencing the instance variable directly?

=begin
with attr_accessor at the public interfaces of the class, clients of the class
could overwrite the value of `@quantity` at any time and cause headaches
Protections built into the `update_quantity` method can be circumvented.
It's a better practice to not reference instance variable directly
=end
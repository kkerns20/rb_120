class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

# Spot the mistake and address it

=begin
The problem arises on line 10 when we attempt to set quantity
without having an explicit setter method or attr_writer.

This will initialize a local variable quantity instead of setting the 
quantity instance variable.

Two possible solutions:

change attr_reader to attr_accessor and then use the setter method with:
`self.quantity = updated_count if updated count >= 0`

OR

reference the instance variable directly within the update_quantity method:
`@quantity = updated_count if updated_count >= 0`
=end
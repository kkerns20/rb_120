=begin
Write a class that implements a miniature stack-and-register-based 
programming language that has the following commands:
  - n => Place a value n in the "register". Do not modify the stack.
  - PUSH => Push the register value on to the stack. Leave the value in the register.
  - ADD => Pops a value from the stack and adds it to the register value, storing the result in the register.
  - SUB => Pops a value from the stack and subtracts it from the register value, storing the result in the register.
  - MULT => Pops a value from the stack and multiplies it by the register value, storing the result in the register.
  - DIV => Pops a value from the stack and divides it into the register value, storing the integer result in the register.
  - MOD => Pops a value from the stack and divides it into the register value, storing the integer remainder of the division in the register.
  - POP => Remove the topmost item from the stack and place in register
  - PRINT => Print the register value
- All operations are integer operations
- Produce error if an unexpected item is present in the string
- Produce an error if required stack value is not on the stack
- In all errors, no further processing should be performed
- Initialize register to 0
=end

class MinilangError < StandardError; end
class EmptyStackError < MinilangError; end
class InvalidTokenError < MinilangError; end

class Minilang
  VALID_COMMANDS = %w(ADD SUB MULT DIV MOD POP PUSH PRINT)

  def initialize(program)
    @stack = Stack.new
    @register = 0
    @program = program
  end

  def eval(params = {})
    new_program = format(program, params)
    new_program.split.each { |token| eval_token(token) }
  rescue MinilangError => error
    puts error.message
  end

  private

  def eval_token(token)
    if VALID_COMMANDS.include?(token)
      send(token.downcase)
    elsif token =~ /\A[-+]?\d+\z/
      self.register = token.to_i
    else
      raise InvalidTokenError, "Invalid token: #{token}"
    end
  end

  def add
    self.register += stack.pop
  end

  def sub
    self.register -= stack.pop
  end

  def mult
    self.register *= stack.pop
  end

  def div
    self.register /= stack.pop
  end

  def mod
    self.register %= stack.pop
  end

  def pop
    self.register = stack.pop
  end

  def push
    stack.push(register)
  end

  def print
    puts register
  end

  attr_accessor :stack, :register, :program
end

class Stack < Array
  def initialize
    @stack = []
  end

  def push(element)
    @stack.push(element)
  end

  def pop
    raise EmptyStackError if @stack.empty?
    @stack.pop
  end
end

Minilang.new('PRINT').eval
# 0

Minilang.new('5 PUSH 3 MULT PRINT').eval
# 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# 5
# 3
# 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# 10
# 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)

# Further Exploration 1
CENTIGRADE_TO_FAHRENHEIT =
  '5 PUSH %<degrees_c>d PUSH 9 MULT DIV PUSH 32 ADD PRINT'
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 100)).eval
# 212
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: 0)).eval
# 32
Minilang.new(format(CENTIGRADE_TO_FAHRENHEIT, degrees_c: -40)).eval
# -40
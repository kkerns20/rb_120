class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

# what will be the result on method calls like...
tv = Television.new      #instantiation
tv.manufacturer          # manufacturer is a class method, so `undefined method manufacturer`
tv.model                 # instance method, so execute method logic

Television.manufacturer  # correct invocation of class method, so execute method logic
Television.model         # model is an instance method, so NoMethodError
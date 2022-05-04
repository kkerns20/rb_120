module Thing
  def self.calling_object
    self
  end
end

p Thing.calling_object          # => Thing
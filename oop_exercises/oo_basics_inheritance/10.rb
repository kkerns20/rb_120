module Transportation
  class Vehicle; end

  class Truck < Vehicle; end

  class Car < Vehicle; end
end

# Instantiate a class that's contained within a module:
Transportation::Truck.new
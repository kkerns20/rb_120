class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

# What is the result of running the following?

trip = RoadTrip.new
trip.predict_the_future
# the `Roadtrip#choices` method will override the `Oracle#choices`
# method
# The output will stil be based on random choices, but from the 
# array in RoadTrip
# `grace` and `ada` are located at the same coordinates
# So why does 39 ouput false
# with the `teleport_to` instance method, we are always creating a new GeoLocation,
# so the object_ids are different. We invoke the `BasicObject#==` and returns false
# Fix it
# We must define a `==` method in out custom class which with override the BasicObject

class Person
  attr_reader :name
  attr_accessor :location

  def initialize(name)
    @name = name
  end

  def teleport_to(latitude, longitude)
    @location = GeoLocation.new(latitude, longitude)
  end
end

class GeoLocation
  attr_reader :latitude, :longitude

  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def ==(other)
    latitude == other.latitude && longitude == other.longitude
  end

  # def ==(other)
    # [latitude, longitude] == [other.latitude, other.longitude]
  # end

  def to_s
    "(#{latitude}, #{longitude})"
  end
end

# Example

ada = Person.new('Ada')
ada.location = GeoLocation.new(53.477, -2.236)

grace = Person.new('Grace')
grace.location = GeoLocation.new(-33.89, 151.277)

ada.teleport_to(-33.89, 151.277)

puts ada.location                   # (-33.89, 151.277)
puts grace.location                 # (-33.89, 151.277)
puts ada.location == grace.location # expected: true
                                    # actual: false
puts ada.location.object_id
puts grace.location.object_id
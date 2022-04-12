=begin
- ammend the implementation details of Graduate and Undergraduate
  - Graduates can use on-campus parking, Undergraduate cannot
  - both Grad and Undergrad have a name an year
- use/alter max 5 lines of code

Further Exploration:
- use super()
=end

class Student
  def initialize(name=nil, year=nil)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name, year)
    @parking = parking
  end

  def to_s
    "#{@name} enrolled in #{@year} and parks in #{@parking}."
  end
end

class Undergraduate < Student
  def initialize(name, year)
    super(name, year)
  end

  def to_s
    "#{@name} enrolled in #{@year}."
  end
end

class Unenrolled < Student
  def initialize
    super()
  end

  def to_s
    "Student currently #{self.class}"
  end
end

kurt = Undergraduate.new("Kurt", "2010")
cole = Graduate.new("Cole", "2013", "West parking")
wit = Unenrolled.new
puts kurt
puts cole
puts wit

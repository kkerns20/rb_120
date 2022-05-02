class Wedding
  attr_reader :guests, :flowers, :songs

  def initialize(guests, flowers, songs)
    @guests = guests
    @flowers = flowers
    @songs = songs
  end

  def prepare(preparers)
    preparers.each do |preparer|
      preparer.prepare_wedding(self)
    end
  end
end

class Chef
  def prepare_wedding(wedding)
    prepare_food(wedding.guests)
  end

  def prepare_food(guests)
    guests.each { |guest| puts "Dinner for #{guest}" }
  end
end

class Decorator
  def prepare_wedding(wedding)
    decorate_venue(wedding.flowers)
  end

  def decorate_venue(flowers)
    puts "Some #{flowers} here, there, and everywhere!"
  end
end

class Musician
  def prepare_wedding(wedding)
    prepare_performance(wedding.songs)
  end

  def prepare_performance(songs)
    songs.each { |song| puts "I'm gonna rock #{song}" }
  end
end

wedding = Wedding.new(['bride', 'groom'], 'lillies', ["Can't help falling in love"])

wedding.prepare([Chef.new, Decorator.new, Musician.new])
# => Dinner for bride
# => Dinner for groom
# => Some lillies here, there, and everywhere!
# => I'm gonna rock Can't help falling in love
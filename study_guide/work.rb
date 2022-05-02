class BasketballGame
  def play(attendees)
    attendees.each do |attendee|
      attendee.participate
    end
  end
end

class Player
  def participate
    play_game
  end

  def play_game
    puts "He shoots, he rebounds, he SCORES!!"
  end
end

class Coach
  def participate
    coach_players
  end

  def coach_players
    puts "Get your hands up and BOX OUT!"
  end
end

class Referee
  def participate
    make_calls
  end

  def make_calls
    puts "<whistle!> Over the back on number 23!"
  end
end

class Cheerleader
  def participate
    cheer_on_team
  end

  def cheer_on_team
    puts "Let's go Bobcats!"
  end
end

the_game = BasketballGame.new

the_game.play([Player.new, Coach.new, Referee.new, Cheerleader.new])
# => He shoots, he rebounds, he SCORES!!
# => Get your hands up and BOX OUT!
# => <whistle!> Over the back on number 23!
# => Let's go Bobcats!
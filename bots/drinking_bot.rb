# This fella needs work. It gives up too easy. It needs to have a random chance of BEING more random.

class DrinkingBot
  include RPS::Bot
  
  def author
    "Hampton Catlin"
  end
  
  def initialize(*args)
    @drunkenness = 0
    super(*args)
    @going_with = moves[rand(3)]
  end
  
  def next
    take_a_drink if history.any? && i_lost_last_round?
    
    if @drunkenness < (rounds_in_game / 2)
      return @going_with
    else
      return moves[rand(3)]
    end
  end
  
  def i_lost_last_round?
    history.last.winner != self
  end
  
  def take_a_drink
    @drunkenness += 1
  end
end
#
# Randomizer!
#
# Created by Hampton Catlin (hcatlin@gmail.com)
#

class Randomizer
  include RPS::Bot
  
  def author
    "Hampton Catlin"
  end
  
  def throw(game)
    # Gets an array of the game.history of the rounds so far
    # 
    # Built like [[:scissors, true], [:rock, false]]
    game.history
    
    # This one selects randomly through the list of available moves
    moves[rand(moves.size)]
  end
end
class Randomizer
  include RSP::Bot
  
  def next
    # Gets an array of the history of the rounds so far
    # 
    # Built like [[:scissors, true], [:rock, false]]
    history
    
    # This one selects randomly through the list of available moves
    moves[rand(moves.size)]
  end
end
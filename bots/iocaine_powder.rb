#
# Iocaine Powder for Ruby
# Searches through the game.history to find common follow up moves
#
# Written by Wesley Moxam
#
class IocainePowder
  include RPS::Bot

  DIE_THRESHOLD = 0.66
  ROUNDS_TO_DIE = 800
  POISONED = 0.2
  
  def author
    "Ported by Wes"
  end

  def throw(game)
    game.history.empty? ? anyone_want_a_peanut? : never_start_a_land_war_in_asia
  end

  def anyone_want_a_peanut?
    moves[rand(moves.size)]
  end

  def never_start_a_land_war_in_asia
    return inconceivable! if poisoned?
    guess!
  end

  def inconceivable!
    # We've been beaten!
    anyone_want_a_peanut?
  end

  def poisoned?
    return false if wins > losses
    return false if losses + wins < ROUNDS_TO_DIE
    return false if (losses - wins).to_f / (losses + wins).to_f < DIE_THRESHOLD
    true
  end

  def intervals
    [1,2,3,4,5].collect {|i| (256 * rand).to_i }
  end

  def guess!
    guesses = []
    intervals.each do |rounds|
        guesses << naive(rounds)
    end
    guesses.compact!
    return anyone_want_a_peanut? if guesses.empty?
    break_em_down(guesses).sort {|a,b| b.length <=> a.length}.first.first
  end

  def naive(n)
    opponent_moves = []
    my_move = game.history.last.my_move(self)
    recent = game.history.reverse[0..n].to_a.reverse
    count_next_round = false
    recent.each do |round|
      opponent_moves << round.other_player_move(self) if(count_next_round)
      count_next_round = (my_move == round.my_move(self))
    end
    return nil if opponent_moves.empty?
    break_em_down(opponent_moves).sort {|a,b| b.length <=> a.length}.first.first.beaten_by
  end

  def break_em_down(moves)
    rocks = moves.select {|m| m.name == :rock}
    papers = moves.select {|m| m.name == :paper}
    scissors = moves.select {|m| m.name == :scissors}
    [rocks, papers, scissors]
  end
end

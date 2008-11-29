#
#  Iocaine Powder for Ruby
#
#  Written by Wes
#
class IocainePowder
  include RPS::Bot

  FOOL_THRESHOLD = 0.5
  DIE_THRESHOLD = 0.66
  ROUNDS_TO_DIE = 800
  POISONED = 0.2
  LONG_INTERVALS = [64, 32, 16, 8, 4, 2, 1]
  SHORT_INTERVALS = [5, 11, 15]
  
  def author
    "Stolen by Wes"
  end

  def next
    history.empty? ? anyone_want_a_peanut? : never_start_a_land_war_in_asia
  end

  def anyone_want_a_peanut?
    moves[rand(moves.size)]
  end

  def never_start_a_land_war_in_asia
    return inconceivable! if poisoned?
    LONG_INTERVALS.each do |rounds|
      move = guess!(rounds)
      return move unless move.nil?
    end
    anyone_want_a_peanut?
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

  def guess!(rounds)
    move = naive(rounds)
    return move if recent_success?(move)
    return double(move) if recent_success?(double(move))
    return triple(move) if recent_success?(triple(move))
    inconceivable!
  end

  def double(move)
    return nil if move.nil?
    move.beaten_by.beaten_by
  end

  def triple(move)
    return nil if move.nil?
    move.beaten_by
  end

  def recent_success?(move)
    SHORT_INTERVALS.reverse.each do |n|
      opponent_moves = []
      my_move = history.last.my_move(self)
      recent = history.reverse[0..n].to_a.reverse
      count_next_round = false
      recent.each do |round|
        opponent_moves << round.other_player_move(self) if(count_next_round)
        count_next_round = (my_move == round.my_move(self))
      end
      break_em_down(opponent_moves).each do |each_move|
        return true if each_move.length.to_f / opponent_moves.length.to_f > FOOL_THRESHOLD
      end
    end
    false
  end

  def naive(n)
    opponent_moves = []
    my_move = history.last.my_move(self)
    recent = history.reverse[0..n].to_a.reverse
    count_next_round = false
    recent.each do |round|
      opponent_moves << round.other_player_move(self) if(count_next_round)
      count_next_round = (my_move == round.my_move(self))
    end
    break_em_down(opponent_moves).each do |each_move|
      return each_move.first.beaten_by if each_move.length.to_f / opponent_moves.length.to_f > FOOL_THRESHOLD
    end
    nil
  end

  def break_em_down(moves)
    rocks = moves.select {|m| m.name == :rock}
    papers = moves.select {|m| m.name == :paper}
    scissors = moves.select {|m| m.name == :scissors}
    [rocks, papers, scissors]
  end

end


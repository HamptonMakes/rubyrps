class RSP::Round
  def my_move(me)
    me == @first_player ? @first_player_move : @second_player_move
  end
end

class IocainePowder
  include RSP::Bot

  FOOL_THRESHOLD = 0.6
  ROUNDS_TO_DIE = 800
  POISONED = 0.2
  INTERVALS = [50, 10, 5, 1]

  def next
    history.empty? ? anyone_want_a_peanut? : never_start_a_land_war_in_asia
  end

  def anyone_want_a_peanut?
    (moves.sort_by { rand() }).first
  end

  def never_start_a_land_war_in_asia
    return inconceivable! if poisoned?
    INTERVALS.each do |rounds|
     move = hippopotamic_land_mass(rounds)
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
    return false if (losses - wins).to_f / (losses + wins).to_f < FOOL_THRESHOLD
    true
  end

  def hippopotamic_land_mass(n)
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

  def opponent_move_breakdown(n)
    last_n_moves = history.reverse[0..n].to_a.collect {|r| r.other_player_move(self)}
    break_em_down(last_n_moves)
  end

  def break_em_down(moves)
    rocks = moves.select {|m| m.name == :rock}
    papers = moves.select {|m| m.name == :paper}
    scissors = moves.select {|m| m.name == :scissors}
    [rocks, papers, scissors]
  end

  def wins
    game.wins(self)
  end

  def losses
    game.losses(self)
  end
end


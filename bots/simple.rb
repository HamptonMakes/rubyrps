class Simple
  include RSP::Bot

  TENDANCY_THRESHOLD = 0.6
  GIVE_UP_THRESHOLD = 0.66
  ROUNDS_TO_DIE = 2000
  POISONED = 0.2
  INTERVALS = [50, 10, 5, 1]

  def next
    history.empty? ? random_move : guess
  end

  def random_move
    (moves.sort_by { rand() }).first
  end

  def guess
    return random if give_up?
    INTERVALS.each do |rounds|
      move = calculate_best_move_in(rounds)
      return move unless move.nil?
    end
    random_move # no good moves, go random
  end

  # if it's hopeless, switch to random to avoid the huge loss
  def give_up?
    return false if wins > losses
    return false if losses + wins < ROUNDS_TO_DIE
    return false if (losses - wins).to_f / (losses + wins).to_f < GIVE_UP_THRESHOLD
    true
  end

  def calculate_best_move_in(n)
    opponent_moves = []
    my_move = history.last.my_move(self)
    recent = history.reverse[0..n].to_a.reverse
    count_next_round = false
    # find all of the follow up moves that the other bot has played against yours
    recent.each do |round|
      opponent_moves << round.other_player_move(self) if(count_next_round)
      count_next_round = (my_move == round.my_move(self))
    end

    # figure out if they play anthing consistant enough to guess on
    extract_moves(opponent_moves).each do |each_move|
      return each_move.first.beaten_by if each_move.length.to_f / opponent_moves.length.to_f > TENDANCY_THRESHOLD
    end
    nil # nothing was good enough to try ...
  end

  def extract_moves(moves)
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


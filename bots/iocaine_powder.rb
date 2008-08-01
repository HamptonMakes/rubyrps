class RSP::Game
  def wins(player)
    first_player.is_a?(player.class) ? first_player_wins : second_player_wins
  end

  def losses(player)
    first_player.is_a?(player.class) ? second_player_wins : first_player_wins
  end
end

class IocainePowder
  include RSP::Bot

  def next
    history.empty? ? anyone_want_a_peanut? : never_start_a_land_war_in_asia
  end

  def anyone_want_a_peanut?
    (moves.sort_by { rand() }).first
  end

  def never_start_a_land_war_in_asia
    return inconceivable! if poisoned?
    return hippopotamic_land_mass if unemployed_in_greenland?
    anyone_want_a_peanut?
  end

  def unemployed_in_greenland?
    opponent_move_breakdown(10).each do |each_move|
      return true if each_move.length > 6
    end
    false
  end

  def inconceivable!
    # We've been beaten!
    anyone_want_a_peanut?
  end

  def poisoned?
    return false if wins > losses
    return false if losses + wins < 800
    return false if (losses - wins).to_f / (losses + wins).to_f < 0.2
    true
  end

  def hippopotamic_land_mass
    opponent_move_breakdown(10).each do |each_move|
      return play_from_prediction(each_move.first) if each_move.length > 6
    end
    inconceivable!
  end

  def play_from_prediction(opponent_move)
    case opponent_move.name
    when :rock
      moves.select {|m| m.name == :paper}.first
    when :scissors
      moves.select {|m| m.name == :rock}.first
    when :paper
      moves.select {|m| m.name == :scissors}.first
    end
  end

  def opponent_move_breakdown(n)
    last_n_rounds = history.reverse[0..n].to_a
    rocks = last_n_rounds.select {|r| r.other_player_move(self).name == :rock}.collect {|r| r.other_player_move(self)}
    papers = last_n_rounds.select {|r| r.other_player_move(self).name == :papers}.collect {|r| r.other_player_move(self)}
    scissors = last_n_rounds.select {|r| r.other_player_move(self).name == :scissors}.collect {|r| r.other_player_move(self)}
    [rocks, papers, scissors]
  end

  def wins
    game.wins(self)
  end

  def losses
    game.losses(self)
  end
end


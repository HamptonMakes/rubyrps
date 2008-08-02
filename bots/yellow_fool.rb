class YellowFool
  include RPS::Bot

  def next
    if history.size > 100 && (history.size / game.losses(self)) > 0.5
      if history.any?
        history.last.other_player_move(self).beaten_by
      else
        moves.first
      end
    else
      moves[rand(moves.size)]
    end
  end
end
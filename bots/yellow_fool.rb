class YellowFool
  include RPS::Bot
  
  def author
    "Hampton Catlin"
  end

  def throw(game)
    if game.history.size > 100 && (game.history.size / game.losses(self)) > 0.5
      if game.history.any?
        game.history.last.other_player_move(self).beaten_by
      else
        moves.first
      end
    else
      moves[rand(moves.size)]
    end
  end
end
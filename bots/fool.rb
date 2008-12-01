#
# Fool
#
# A P0 bot
#
# Created by Hampton Catlin (hcatlin@gmail.com)
#
class Fool
  include RPS::Bot
  
  def author
    "Hampton Catlin"
  end
  
  def throw(game)
    if game.history.any?
      game.history.last.other_player_move(self).beaten_by
    else
      moves.first
    end
  end
end

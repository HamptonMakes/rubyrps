#
# Fool
#
# A P0 bot
#
# Created by Hampton Catlin (hcatlin@gmail.com)
#
class Fool
  include RPS::Bot
  
  def next
    if history.any?
      history.last.other_player_move(self).beaten_by
    else
      moves.first
    end
  end
end

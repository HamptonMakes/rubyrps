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
  
  def next
    if history.any?
      history.last.other_player_move(self).beaten_by
    else
      moves.first
    end
  end
end

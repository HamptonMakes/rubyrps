#
# Stubborn!
#
# Created by Hampton Catlin (hcatlin@gmail.com)
#
class Stubborn
  include RPS::Bot
  
  def author
    "Hampton Catlin"
  end
  
  def throw(game)
    # good ol' rock... nothin' beats that!
    moves.first
  end
end
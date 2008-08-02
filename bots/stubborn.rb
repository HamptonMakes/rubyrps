#
# Stubborn!
#
# Created by Hampton Catlin (hcatlin@gmail.com)
#
class Stubborn
  include RPS::Bot
  
  def next
    # good ol' rock... nothin' beats that!
    moves.first
  end
end
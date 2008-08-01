class Stubborn
  include RSP::Bot
  
  def next
    moves.first
  end
end
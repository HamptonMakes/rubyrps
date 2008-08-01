require 'lib/move'

module RSP
  MOVES = [Move.new(:rock, :paper), Move.new(:scissors, :rock), Move.new(:paper, :scissors)].freeze
  @@bots = []
  
  def self.add(bot_klass)
    @@bots << bot_klass
  end
  
  def self.bots
    @@bots
  end
  
  def self.run
    @@bots.each do |bot|
      (@@bots - [bot]).each do |other_bot|
        game = Game.new(bot, other_bot)
        game.execute
      end
    end
  end
end

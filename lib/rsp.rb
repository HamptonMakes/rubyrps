require 'lib/move'

module RSP
  MOVES = [Move.new(:rock), Move.new(:scissors), Move.new(:paper)].freeze
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

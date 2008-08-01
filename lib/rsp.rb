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
    game_record = {}
    @@bots.each do |bot|
      game_record[bot] = {:wins => 0, :loses => 0, :draws => 0}
    end
    
    @@bots.each do |bot|
      (@@bots - [bot]).each do |other_bot|
        game = Game.new(bot, other_bot)
        game.execute
        
        if game.winner == bot
          game_record[bot][:wins]        += 1
          game_record[other_bot][:loses] += 1
        elsif game.winner == other_bot
          game_record[other_bot][:wins]  += 1
          game_record[bot][:loses]       += 1
        else
          game_record[other_bot][:draws] += 1
          game_record[bot][:draws]       += 1
        end
      end
    end
  end
end

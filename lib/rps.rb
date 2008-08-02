require 'lib/move'

module RPS
  MOVES = [Move.new(:rock, :paper), Move.new(:scissors, :rock), Move.new(:paper, :scissors)].freeze
  @@bots = []
  
  def self.add(bot_klass)
    @@bots << bot_klass
  end
  
  def self.bots
    @@bots
  end

  def self.select(bots)
    return if bots.empty?
    @@bots.reject! {|b| !bots.include?(b.to_s)}
  end

  def self.run(bots)
    select(bots)
    game_record = {}
    @@bots.each do |bot|
      game_record[bot] = {:wins => 0, :losses => 0, :draws => 0}
    end
    
    @@bots.each do |bot|
      (@@bots - [bot]).each do |other_bot|
        game = Game.new(bot, other_bot)
        game.execute

        
        if game.winner.class == bot
          game_record[bot][:wins]        += 1
          game_record[other_bot][:losses] += 1
        elsif game.winner.class == other_bot
          game_record[other_bot][:wins]  += 1
          game_record[bot][:losses]       += 1
        else
          game_record[other_bot][:draws] += 1
          game_record[bot][:draws]       += 1
        end
      end
    end
    
    
    puts "------------------\n\n"
    game_record.each do |bot, data|
      puts bot.to_s + "\t\tW#{data[:wins]}, L#{data[:losses]}, D#{data[:draws]}"
      
    end
  end
end

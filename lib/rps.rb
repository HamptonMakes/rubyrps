require 'lib/move'
require 'thread'

module RPS
  MOVES = [Move.new(:rock, :paper), Move.new(:scissors, :rock), Move.new(:paper, :scissors)].freeze
  @@bots = []
  @@threaded = false
  @@options = %w{ --threaded }

  def self.add(bot_klass)
    @@bots << bot_klass
  end

  def self.bots
    @@bots
  end

  def self.extract_bots(options)
    options - @@options
  end

  def self.set_options(options)
    @@threaded = options.include?('--threaded')
  end

  def self.select_bots(options)
    return if options.empty?
    @@bots.reject {|b| options.include?(b.to_s)}
  end

  def self.run(options)
    set_options(options)
    select_bots(extract_bots(options))
    tournament = {}
    @@bots.each do |bot|
      tournament[bot] = {:wins => 0, :losses => 0, :draws => 0, :bot => bot.new}
    end

    puts 'Running in parallel' if @@threaded

    lock = Mutex.new
    t = []

    @@bots.each do |bot|
      (@@bots - [bot]).each do |other_bot|
        if @@threaded
          t << Thread.new do
            game(bot, other_bot, tournament, lock)
          end
        else
          game(bot, other_bot, tournament, lock)
        end
      end
    end

    t.each {|thread| thread.join} if @@threaded

    puts "------------------\n\n"
    tournament.each do |bot, data|
      puts bot.to_s + "\t\tW#{data[:wins]}, L#{data[:losses]}, D#{data[:draws]}"
    end
  end

  def self.game(bot, other_bot, tournament, lock)
    game = Game.new(bot, other_bot)
    game.execute
    lock.synchronize do
      if game.winner.class == bot
        tournament[bot][:wins]        += 1
        tournament[other_bot][:losses] += 1
      elsif game.winner.class == other_bot
        tournament[other_bot][:wins]  += 1
        tournament[bot][:losses]       += 1
      else
        tournament[other_bot][:draws] += 1
        tournament[bot][:draws]       += 1
      end
      puts game
    end
  end
end

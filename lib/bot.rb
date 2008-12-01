module RPS
  
  module Bot
    attr_accessor :game
    attr_accessor :wins, :losses
    
    def self.included(klass)
      RPS.add(klass)
    end
    
    def initialize(game)
      @wins, @losses = 0, 0
    end
    
    def moves
      RPS::MOVES
    end

    def to_s
      self.class.to_s
    end
  end
end
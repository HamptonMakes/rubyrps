module RPS
  
  module Bot
    attr_accessor :game
    attr_accessor :wins, :losses
    
    def self.included(klass)
      RPS.add(klass)
    end
    
    def initialize(game)
      @game = game
      @wins, @losses = 0, 0
    end
    
    def history
      @game.history
    end
    
    def moves
      RPS::MOVES
    end
    
    def wins
      game.wins(self)
    end

    def losses
      game.losses(self)
    end
    
    def to_s
      self.class.to_s
    end
  end
end
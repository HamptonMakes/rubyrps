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
    
    def rounds_in_game
      @game.rounds_to_run
    end
    
    def rounds_so_far
      history.size
    end
    
    def rounds_left
      rounds_in_game - rounds_so_far
    end
    
    def to_s
      self.class.to_s
    end
  end
end
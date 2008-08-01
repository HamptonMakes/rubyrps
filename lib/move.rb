module RSP
  class Move
    include Comparable
    
    attr_reader :name
    
    def initialize(name)
      @name = name
    end
    
    def to_s
      name.to_s
    end

    def <=>(other)
      return 0 if self.name == other.name
      
      win = 1
      lose = -1

      # This should be *severely* cleaned up
      if self.name == :rock && other.name == :scissors
        win
      elsif self.name == :rock && other.name == :paper
        lose
      elsif self.name == :scissors && other.name == :rock
        lose
      elsif self.name == :scissors && other.name == :paper
        win
      elsif self.name == :paper && other.name == :rock
        win
      elsif self.name == :paper && other.name == :scissors
        lose
      else
        nil
      end
    end
  end
end
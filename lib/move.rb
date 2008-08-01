module RSP
  class Move
    include Comparable
    
    attr_reader :name, :beaten_by_sym, :beats
    
    def initialize(name, beaten_by_sym)
      @name, @beaten_by_sym = name, beaten_by_sym
    end
    
    def beats
      @beats ||= (RSP::MOVES.find { |m| m.beaten_by_sym == self.name })
    end
    
    def beaten_by
      @beats ||= (RSP::MOVES.find { |m| m.name == self.beaten_by_sym })
    end
    
    def to_s
      name.to_s
    end

    def <=>(other)
      result = 0
      result += 1  if other.beaten_by_sym == @name
      result -= 1  if @beaten_by_sym == other.name
      result
    end
  end
end
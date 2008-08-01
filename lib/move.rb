module RSP
  class Move
    include Comparable
    
    attr_reader :name, :beaten_by
    
    def initialize(name, beaten_by)
      @name, @beaten_by = name, beaten_by
    end
    
    def to_s
      name.to_s
    end

    def <=>(other)
      result = 0
      result += 1  if other.beaten_by == @name
      result -= 1  if @beaten_by == other.name
      result
    end
  end
end
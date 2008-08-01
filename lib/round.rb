module RSP
  class Round
    attr_reader :first_player, :second_player, :first_player_move, :second_player_move, :winner
    
    def initialize(first_player, second_player)
      @first_player, @second_player = first_player, second_player
      execute
    end
    
    def other_player_move(my_player)
      my_player == @first_player ? @second_player_move : @first_player_move
    end
    
    def to_s
      result = ""
      [[@first_player, @first_player_move], [@second_player, @second_player_move]].each_with_index do |set, index|
        player, move = set
        result << "Player #{index + 1} (#{player}) - #{move} - "
        if player == @winner
          result << "WON!\n"
        elsif @winner == false
          result << "tied\n"
        else
          result << "lost\n"
        end
      end
      result
    end
    
   private
   
    def execute
      @first_player_move = first_player.next
      @second_player_move = second_player.next
      
      if first_player_move > second_player_move
        @winner = first_player
      elsif first_player_move < second_player_move
        @winner = second_player
      else
        @winner = false
      end
    end
    
  end
end

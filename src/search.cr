module Game543

  class Search

    @board : Board

    def initialize(board)
      @board = board
    end

    def find_move
      puts "Searching..."
      # random_move
      minimax
    end

    def random_move
      available_moves = @board.available_moves
      random_move_index = rand(0..available_moves.size)
      available_moves[random_move_index]
    end

    def minimax
      Minimax.new(@board).search
    end

  end

end

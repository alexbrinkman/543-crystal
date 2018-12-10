module Game543

  class MinimaxNode

    property :board
    property :moves
    property :value

    @board : Board

    def initialize(board)
      @board = board
      @moves = [] of MinimaxNode
      @value = 0
    end

  end

end

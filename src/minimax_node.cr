module Game543

  class MinimaxNode

    MAX_DEPTH = 8

    property :board
    property :moves
    property :value

    @board : Board

    def initialize(board)
      @board = board
      @moves = [] of MinimaxNode
      @value = 0
    end

    def build_tree(board, depth=0)
      root_node = MinimaxNode.new(board)
      return root_node if depth > MAX_DEPTH
      board.available_moves.each do |b|
        root_node.moves << build_tree(b, depth + 1)
      end
      root_node
    end

  end

end

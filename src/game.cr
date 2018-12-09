module Game543
  class Game

    def initialize
      @board = Board.new(Board.initial_board)
      @whos_move = :human
      run
    end

    private def run
      puts @board.to_s
      loop do
        make_move
        if @board.winner?
          puts "#{@whos_move} wins!"
          exit
        end
        switch_players
      end
    end

    private def make_move
      if @whos_move == :human
        move = prompt_for_move
        begin
          @board.move(move[0], move[1])
        rescue e : ArgumentError
          puts e.message
        end
      else
        @board = Search.new(@board).find_move
      end
      puts @board.to_s
    end

    private def prompt_for_move
      puts "Your move: (row)"
      row = gets
      puts "Your move: (num)"
      num = gets
      [row, num]
    end

    private def switch_players
      @whos_move = @whos_move == :human ? :computer : :human
    end

  end
end

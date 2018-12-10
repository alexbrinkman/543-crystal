module Game543
  class Board

    @position : Array(Array(Bool))

    def initialize(position)
      @position = position
    end

    def move(row, num)
      row = row ? row.to_i : 0
      num = num ? num.to_i : 0
      validate_move(row, num)
      update_board(row, num)
    end

    def winner?
      total_pieces_left == 1
    end

    def available_moves
      # One move for each piece of each row, unless there are only pieces left in one row.
      boards = [] of Board
      start_at = one_row_left? ? 1 : 0
      @position.each_with_index do |row, index|
        (start_at..row.size - 1).each do |i|
          new_position = @position.dup
          new_position[index] = create_row(i)
          boards << Board.new(new_position)
        end
      end
      boards
    end

    def self.initial_board
      [
        [true, true, true],
        [true, true, true, true],
        [true, true, true, true, true]
      ]
    end

    def to_s
      str = String.build do |str|
        str << "---------\n"
        @position.each_with_index do |row, index|
          str << "row #{index + 1}: "
          row.select { |e| e }.size.times { str << "O " }
          str << "\n"
        end
        str << "---------"
      end
      str
    end

    private def validate_move(row, num)
      raise ArgumentError.new("Invalid row: please enter 1-#{@position.size}.") if row < 1 || row > @position.size
      raise ArgumentError.new("Invalid number: please enter at least 1 piece.") if num < 1
      raise ArgumentError.new("Invalid number: please enter no more than the number remaining in the row.") if num > pieces_left_in_row(row)
      raise ArgumentError.new("Invalid number: you may not take all remaining pieces.") if num >= total_pieces_left
    end

    private def pieces_left_in_row(row)
      @position[row - 1].select { |e| e }.size
    end

    private def total_pieces_left
      @position.flatten.size
    end

    private def one_row_left?
      @position.size.times do |row|
        return true if pieces_left_in_row(row + 1) == total_pieces_left
      end
      false
    end

    private def update_board(row, num)
      new_row = [] of Bool
      (pieces_left_in_row(row) - num).times { new_row << true }
      @position[row - 1] = new_row
    end

    private def create_row(pieces)
      row = [] of Bool
      pieces.times { row << true }
      row
    end

  end
end

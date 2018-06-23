require_relative 'tic_tac_toe'

class TicTacToeNode

  attr_reader :board, :next_mover_mark, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over? && @board.winner != evaluator
      return true
    elsif @board.over?
      return false
    else
      moves = children

      moves.each do |move|
        loser = move.losing_node?(evaluator)
        
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over? && @board.winner == evaluator
      return true
    elsif @board.over?
      return false
    else
      moves = children
      moves.each { |move| return move.winning_node?(evaluator) }
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    moves = []
    #go through each empty spot on Board
      #dupe board, add next-mover-mark -- X or O, depending
      # create nod
    next_mark = (@next_mover_mark == :o) ? :x : :o
    @board.rows.each_with_index do |row, idx1|
      row.each_with_index do |mark, idx2|
        pos = [idx1, idx2]
        if @board.empty?(pos)
          new_board = @board.dup
          new_board[pos] = next_mark
          moves << TicTacToeNode.new(new_board, next_mark, pos)
        end
      end
    end
    moves
  end
end

require_relative "00_tree_node"

class KnightPathFinder

  STEPS = [-2, -1, 1, 2]

  def initialize(start_pos)
    @visited_positions = [start_pos]
    build_move_tree(start_pos)
  end

  def build_move_tree(pos)
    # @move_tree = PolyTreeNode.new(pos)
    @move_tree = PolyTreeNode.new(pos)
    queue = [@move_tree]
    until queue.empty?
      node = queue.shift
      moves = new_move_positions(node.value)
      moves.each do |child_pos|
        child = PolyTreeNode.new(child_pos)
        node.add_child(child)
        queue << child
      end

    end


  end

  def new_move_positions(pos)
    moves = KnightPathFinder.valid_moves(pos)
    moves.reject! {|move| visited_positions.include?(move)}
    @visited_positions += moves
    moves
  end

  def find_path(end_pos)
    end_node = move_tree.bfs(end_pos)
    trace_path_back(end_node)
  end

  def trace_path_back(node)
    path = []
    until node.parent.nil?
      path << node.value
      node = node.parent
    end
    path << node.value
    path.reverse
  end

  def self.valid_moves(pos)
    moves = []

    STEPS.each do |row|
      STEPS.each do |col|
        next if row.abs + col.abs != 3
        new_row, new_col = pos[0] + row, pos[1] + col
        if (0..7).include?(new_row) && (0..7).include?(new_col)
          moves << [new_row, new_col]
        end
      end
    end

    moves
  end

  private
  attr_reader :visited_positions, :move_tree

end

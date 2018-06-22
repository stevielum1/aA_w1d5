require 'byebug'

class PolyTreeNode

  attr_reader :parent


  def initialize(value)
    @value = value
    @parent = nil
    @children_array = []
  end

  def children
    @children_array.dup
  end

  def value
     @value.dup
  end

  def parent=(new_parent)
    unless @parent.nil?
      @parent.children_array.delete(self)
    end
    @parent = new_parent
    unless new_parent.nil?
      new_parent.children_array << self
    end
  end

  def add_child(new_child)
    new_child.parent = self
  end

  def remove_child(child)
    raise "Not a child of this parent" unless children_array.include?(child)
    child.parent = nil
  end

  def dfs(target_value)
    return self if self.value == target_value
    unless children_array.empty?
      children_array.each do |child|
        result = child.dfs(target_value)
        return result unless result.nil?
      end
    end
    nil
  end

  def bfs(target_value)
    queue = [self]
    until queue.empty?
      node = queue.shift
      return node if node.value == target_value
      node.children_array.each {|child| queue << child}
    end
    nil
  end

  def inspect
    puts "#<PolyTreeNode:#{self.object_id} value=#{value}>"
  end

  protected
    attr_accessor :children_array



end

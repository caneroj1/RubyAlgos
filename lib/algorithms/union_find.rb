module Algorithms
  class UnionFind
    # the union find class has a set that represents the set of vertices that belongs to the graph
    # there is also a size array that represents the number of vertices contained in the tree
    attr_accessor :set, :size

    # initializes the set array to contain [0, 1, 2, ... , n]
    # this represents each vertex
    def initialize(size_of_set)
      @set, @size = [], []
      (0..size_of_set).each do |i|
        @set << i
        @size << 1
      end
    end

    # this walks up the union-find tree in order to determine the root of a subtree
    # each position in the array @set stores the root of that vertex's tree.
    # we recursively walk up positions in the array
    def find(vertex)
      if @set[vertex].eql?(vertex)
        vertex
      else
        find(@set[vertex])
      end
    end

    # this function unions two sets
    # it finds the roots of the two sets, and if they are the same, it does nothing.
    # if they are different, we make the larger subtree the parent of the smaller subtree
    # this results in the height of the smaller subtree only increasing by 1 (since we are adding a new root)
    # and has the effect of bounding the height of the tree.
    def union(vertex_one, vertex_two)
      root_one = find(vertex_one)
      root_two = find(vertex_two)
      if !root_one.eql?(root_two)
        if @size[root_one] >= @size[root_two]
          @size[root_one] += @size[root_two]
          @set[root_two] = root_one
        else
          @size[root_two] += @size[root_one]
          @set[root_one] = root_two
        end
      end
    end

    # the same component test. this walks up the union-find "tree" in order to determine
    # if two vertices are in the same component (i.e. have the same root node)
    # returns true or false
    def same_component?(vertex_one, vertex_two)
      find(vertex_one) == find(vertex_two)
    end
  end
end

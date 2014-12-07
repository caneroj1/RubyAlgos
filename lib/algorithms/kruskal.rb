module Algorithms
  class Kruskal
    require_relative 'union_find'
    require_relative 'edge'
    require_relative 'breadth_first_search'

    # kruskal's algorithm has a graph that is passed in so the algorithm can execute
    # from this graph, we create an edge array
    attr_reader :graph, :edges

    def initialize(g)
      @graph = g
      @edges = create_edge_array
    end

    def find
      sort_edges
      union_find = Algorithms::UnionFind.new(@graph.number_vertices)
      (0..@graph.number_edges).each do |i|
        if (!union_find.same_component?(@edges[i].x, @edges[i].y))
          puts "Minimum spanning tree has edge #{@edges[i].x} <-> #{@edges[i].y}"
          union_find.union(@edges[i].x, @edges[i].y)
        end
      end
    end

    private

    # creates an array that holds each edge in the graph
    # the edge array is used to systematically look for edges so the union-find
    # data structure can work. The edge array is created via breadth-first search
    def create_edge_array
      edges = []
      process_edge = lambda { |x, y, w| edges.push Edge.new(x, y, w) }
      Algorithms::BreadthFirstSearch.go(@graph, 1, nil, nil, process_edge)
      edges
    end

    # sorts the edges based on their weight
    def sort_edges
      @edges.sort! do |x, y|
        if x.weight > y.weight
          1
        elsif x.weight < y.weight
          -1
        else
          0
        end
      end
    end
  end
end

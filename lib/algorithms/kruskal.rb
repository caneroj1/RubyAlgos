module Algorithms
  class Kruskal
    require_relative 'union_find'
    require_relative 'edge'
    require_relative 'breadth_first_search'

    # kruskal's algorithm has a graph that is passed in so the algorithm can execute
    # from this graph, we create an edge array
    # the attribute weight stores the weight of the spanning tree
    attr_reader :graph, :edges, :weight

    def initialize(g)
      @graph = g
      @weight = 0
      create_edge_array
    end

    def find
      puts "Finding the minimum spanning tree of #{@graph.graph_name}"
      sort_edges
      union_find = Algorithms::UnionFind.new(@graph.number_vertices)
      (0...@graph.number_edges).each do |i|
        puts "#{i}"
        if (!union_find.same_component?(@edges[i].x, @edges[i].y))
          puts "Minimum spanning tree has edge #{@edges[i].x} <-> #{@edges[i].y}"
          union_find.union(@edges[i].x, @edges[i].y)
          @weight += @edges[i].weight
        end
      end
    end

    def weight
      "Weight of the minimum spanning tree: #{@weight}"
    end

    private

    # creates an array that holds each edge in the graph
    # the edge array is used to systematically look for edges so the union-find
    # data structure can work. The edge array is created via breadth-first search
    def create_edge_array
      @edges = []
      process_edge = lambda { |x, y, w| @edges.push Edge.new(x, y, w) }
      Algorithms::BreadthFirstSearch.go(@graph, 1, nil, nil, process_edge)
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

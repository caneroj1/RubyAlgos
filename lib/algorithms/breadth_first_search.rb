module Algorithms
  class BreadthFirstSearch
    attr_reader :parent, :processed, :discovered, :queue

    class << self

      # breadth-first search where you can pass in functions to be run for
      # process_vertex_early, process_vertex_late, and process_edge functions.
      # you also pass in the graph to be traversed
      def go(g, start_vertex, process_v_early, process_v_late, process_edge)
        graph = g.clone

        process_v_early ||= lambda { |v| nil }
        process_v_late  ||= lambda { |v| nil }
        process_edge    ||= lambda { |x, y, w| nil }

        @parent = Array.new(graph.number_vertices + 1, -1)
        @processed = Array.new(graph.number_vertices + 1, false)
        @discovered = Array.new(graph.number_vertices + 1, false)
        @queue = []

        @queue << start_vertex
        @discovered[start_vertex] = true
        while(!@queue.empty?)
          v = @queue.shift

          process_v_early.call(v)
          @processed[v] = true

          v_edges = []
          if !graph.adjacency_list[v].nil?
            v_edges = graph.adjacency_list[v].clone
          end

          while(!v_edges.empty?)
            y = v_edges.shift
            process_edge.call(v, y.next, y.weight) if (!@processed[y.next] || graph.directed)

            if !@discovered[y.next]
              @queue << y.next
              @discovered[y.next] = true
              @parent[y.next] = v
            end

          end # end second while
          process_v_late.call(v)
        end # end first while
        @parent
      end # end go function

      ## this function checks to see how many connected components there are in the given graph
      # it loops until it goes through all of the vertices, and if there is a vertex at one point in the loop
      # that has not been discovered, we do BFS on it to explore the rest of the component in which that vertex resides.
      def connected_components(g)
        @components = 1
        num_vertices = 1
        process_v_early = lambda { |v| puts "#{v} in #{@components}"}

        @discovered = []

        loop do
          if !@discovered[num_vertices]
            self.go(g, num_vertices, process_v_early, nil, nil)
            @components += 1
          end
          num_vertices += 1
          break if(num_vertices > g.number_vertices)
        end

        @components
      end

      ## this function will check to see if a graph is bipartite. a graph is bipartitie
      # if each vertex can be assigned a color, with its neighboring vertices being the opposite color.
      # we will use black and white as our two colors
      def two_color(g)
        @bipartite = true
        @color = Array.new(g.number_vertices + 1, :uncolored)
        num_vertices = 1

        @discovered = []

        process_edge =
        lambda do |x, y, w|
          if @color[x].eql?(@color[y])
            @bipartite = false
            puts "Problem Edge: #{x} and #{y}"
          end

          if @color[x].eql?(:white)
            @color[y] = :black
          else
            @color[y] = :white
          end
        
        end

        loop do
          if !@discovered[num_vertices]
            @color[num_vertices] = :white
            self.go(g, num_vertices, nil, nil, process_edge)
          end
          num_vertices += 1
          break if(num_vertices > g.number_vertices)
        end

        @bipartite
      end

    end # end class << self
  end
end

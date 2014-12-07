module Algorithms
  class BreadthFirstSearch
    class << self

      # breadth-first search where you can pass in functions to be run for
      # process_vertex_early, process_vertex_late, and process_edge functions.
      # you also pass in the graph to be traversed
      def go(g, start_vertex, process_v_early, process_v_late, process_edge)
        graph = g.dup

        process_v_early ||= lambda { |v| nil }
        process_v_late  ||= lambda { |v| nil }
        process_edge    ||= lambda { |x, y, w| nil }

        parent = Array.new(graph.number_vertices + 1, 0)
        processed = Array.new(graph.number_vertices + 1, false)
        discovered = Array.new(graph.number_vertices + 1, false)
        queue = []

        queue << start_vertex
        discovered[start_vertex] = true
        while(!queue.empty?)
          v = queue.shift

          process_v_early.call(v)
          processed[v] = true

          v_edges = graph.adjacency_list[v]
          while(!v_edges.empty?)
            y = v_edges.shift
            process_edge.call(v, y.next, y.weight) if (!processed[y.next] || g.directed)

            if !discovered[y.next]
              queue << y.next
              discovered[y.next] = true
              parent[y.next] = v
            end

          end # end second while
          process_v_late.call(v)
        end # end first while
        parent
      end # end go function

    end # end class << self

  end
end

module Algorithms
  class Graph
    require_relative 'node'
    require_relative 'breadth_first_search'

    attr_reader :path, :adjacency_list, :number_vertices, :number_edges, :directed, :weighted

    # graph implementation using an adjacency list.
    # accepts a filename where the graph is stored.
    # will initialize the graph by reading the file.
    def initialize(filename, options = {})
      @path = filename
      parse_options(options)
      create_graph
    end

    # prints the graph in a nice easily readable format
    def display
      puts "------- Graph -------"
      (1..@number_vertices).each do |i|
        print("#{i} -> ")
        @adjacency_list[i].each { |node| print ("#{node.next} ") }
        print("\n\n")
      end
    end

    # gets the shortest path between two vertices
    # if the graph is unweighted, we can simply use breadth-first search
    # and then we traverse up the parent array.
    # if the graph is weighted, use dijkstra's algorithm
    def path(vertex_one, vertex_two)
      if !weighted
        puts "Path from #{vertex_one} to #{vertex_two}"
        get_path(Algorithms::BreadthFirstSearch.go(self, vertex_one, nil, nil, nil), vertex_one, vertex_two)
        puts "---"
      else
        puts "The graph is weighted."
        puts "Dijkstra's Not Implemented."
      end
    end

    private

    # will parse the open file
    # stores the number of vertices and edges in @number_vertices, @number_edges.
    # loops through the file line by line, and creates vertices to make the graph.
    def create_graph
      graph = open_file

      graph.each_line.with_index do |line, index|
        if index.eql? 0
          basic_initialization(line)
        else
          insert_edge(line.split(' '))
        end
      end
    end

    # opens the graph file in read only mode
    def open_file
      File.open(@path, 'r')
    end

    # gets the number of vertices and edges
    # then creates the skeleton of the adjacency list.
    def basic_initialization(line)
      split_line = line.split(' ')
      @number_vertices, @number_edges = split_line[0].to_i, split_line[1].to_i
      create_adjacency_list
    end

    # creates the adjacency list by initializing an array of length |V|
    # to hold arrays of Nodes
    def create_adjacency_list
      @adjacency_list = Array.new(@number_vertices + 1) { [] }
    end

    # inserts an edge into the adjacency list
    # the line is split by space. the first index is the current vertex we are at. this is used
    # as the index into the adjacency list. next, all the other numbers indicate which vertex the current one
    # connects to.
    def insert_edge(data, continue = true, weight = nil)
      index = data.shift
      weight ||= -1
      data.each do |v|
        if @weighted && weight.eql?(-1)
          tmp = v.split(',')
          v, weight = tmp[0], tmp[1]
        end

        @adjacency_list[index.to_i].push Node.new(v.to_i, weight.to_i)
        insert_edge([v, index], false, weight) if (!@directed && continue && @adjacency_list[v.to_i].nil?)
        weight = -1
      end
    end

    # parses the options array passed into the initialization
    def parse_options(options)
      @directed = options[:directed] || nil
      @weighted = options[:weighted] || nil
    end

    # traverses up the parent array in reverse
    def get_path(parent, start, end_v)
      if start.eql?(end_v) || end_v.eql?(-1)
        puts start
      else
        get_path(parent, start, parent[end_v])
        puts end_v
      end
    end
  end
end

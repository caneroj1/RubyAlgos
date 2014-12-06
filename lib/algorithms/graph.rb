module Algorithms
  class Graph
    require_relative 'node'
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
        print("\n")
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
    def insert_edge(data, continue = true)
      index = data.shift
      data.each do |v|
        @adjacency_list[index.to_i].push Node.new(v.to_i, 0)
        insert_edge([v, index], false) if (!@directed && continue && @adjacency_list[v.to_i].nil?)
      end
    end

    # parses the options array passed into the initialization
    def parse_options(options)
      @directed = options[:directed] || nil
      @weighted = options[:weighted] || nil
    end
  end
end

module Algorithms
  class EditDistance
    attr_reader :edit_matrix, :distance
    attr_accessor :x, :y
    
    ## initialize the Edit Distance algorithm
    # accepts two strings: X and Y and creates a matrix of size |X| * |Y|
    # we want to pad @x and @y with a single space character in the beginning
    # we finally transform @edit_matrix so that the first row starts from 0 and goes to |Y| - 1
    # and so the first column goes from 0 to |X| - 1
    def initialize(x, y)
      @x = ' ' << x
      @y = ' ' << y
      @edit_matrix = Array.new(@y.length) { Array.new(@x.length, 0) }
      transform_matrix
    end

    ## compute the edit distance of the two strings
    def edit_distance
      # start from the first character in both x and y, not the first index of the string
      # the first character is at index 1, but y_index and x_index start at 0, so we must add 1 to that value in order
      # to be at the proper spot in @edit_matrix
      @y[1...@y.length].each_char.with_index do |y, y_index|
        @x[1...@x.length].each_char.with_index do |x, x_index|
          options = { :match  => @edit_matrix[y_index][x_index] + match(x, y),
                      :insert => @edit_matrix[y_index + 1][x_index] + indel,
                      :delete => @edit_matrix[y_index][x_index + 1] + indel }

          @edit_matrix[y_index + 1][x_index + 1] = options[:match]
          options.each_value { |value| @edit_matrix[y_index + 1][x_index + 1] = value if value < @edit_matrix[y_index + 1][x_index + 1] }
        end
      end
      @distance = @edit_matrix[@y.length - 1][@x.length - 1]
    end


    private

    ## match function
    # if the passed in characters match, return 0.
    # else return 1 for a substitution
    def match(x, y)
      x.eql?(y) ? 0 : 1
    end

    ## indel function
    # returns 1, as we are either performing a delete or an insertion.
    # this is because indels are performed when we are not dealing with substrings
    # of equal length, so we must either insert something or delete something to make them equal.
    def indel
      1
    end

    ## transform_matrix
    # initializes the matrix in its proper form for the edit distance algorithm
    def transform_matrix
      (0...@x.length).each { |i| @edit_matrix[0][i] = i }
      (0...@y.length).each { |i| @edit_matrix[i][0] = i }
    end
  end
end
